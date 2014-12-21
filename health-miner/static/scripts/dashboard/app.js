angular.module('ViewRecordApp', [])
	.controller('ViewRecordCtrl', ['$scope', '$http', '$q', 'apiUrls', 'renderDiagnosis', 'renderChart', 'patientChartTypes', '$sce', 
								   function(scope, http, $q, apiUrls, renderDiagnosis, renderChart, patientChartTypes, $sce){

		var extend = function(Child, Parent){
	        var F = function(){};
	　　　　F.prototype = Parent.prototype;
	　　　　Child.prototype = new F();
	　　　　Child.prototype.constructor = Child;
	　　　　Child.uber = Parent.prototype;
	    }
		/**
		* Model
		*/
		var Patient = function(data){
			this.id = data.id;
			this.user = data.user;
			this.medicalRecords = [];
		}

		Patient.prototype.loadRecords = function(){
			var self = this;
			http.get(apiUrls.apiLoadPatientRecords, {'params': {'patient_id': self.id}})
				.success(function(res){
					self.medicalRecords = res.records.map(function(r){
						r.patient = self;
						return new MedicalRecord(r);
					});
				})
				.error(function(){});
		}

		Patient.prototype.getGuid = function(){
			return this.user.guid;
		}

		Patient.prototype.getUsername = function(){
			return this.user.username;
		}

		Patient.prototype.getRegisterTime = function(){
			return this.user.register_time;
		}

		Patient.prototype.getMedicalRecords = function(){
			/** Sorted according to serial number, which is a hex string */
			return this.medicalRecords.sort(function(m1, m2){
				return m2.serial_number_integer - m1.serial_number_integer;
			});
		}

		Patient.prototype.getName = function(){
			return this.user.name;
		}

		Patient.prototype.getId = function(){
			return this.user.username;
		}

		Patient.prototype.getStatistic = function(name){
			var defered = $q.defer();
			var params = {'patient_id': this.id};
			params[name] = true;

			http.get(apiUrls.apiLoadPatientStatistic, {'params': params})
				.success(function(res){
					defered.resolve(res);
				})
				.error(function(e){
					defered.reject(e);
				});

			return defered.promise;
		}

		var MedicalRecord = function(obj){
			this.id = obj.id;
			this.serial_number = obj.serial_number;
			this.data = obj.data;
			this.upload_time = obj.upload_time;
			this.record_time = obj.record_time;
			this.patient = new Patient(obj.patient);
			this.comments = obj.comments;
			
			var idx = this.serial_number.indexOf('_');
			if(idx >= 0)
				this.serial_number_integer = parseInt(this.serial_number.substring(idx + 1, this.serial_number.length), 16) || -1;
			else
				this.serial_number_integer = parseInt(this.serial_number, 16) || -1;
		}

		MedicalRecord.prototype.getRenderHtml = function(){
			return $sce.trustAsHtml(renderDiagnosis(this));
		}

		MedicalRecord.prototype.getPatient = function(){ return this.patient;}

		var Panel = function(data){
			for(key in data){
				this[key] = data[key];
			}
		}

		Panel.prototype.init = function(){
			this.renderedHtml = $sce.trustAsHtml('<div>正在加载...</div>');
		}

		Panel.prototype.getRenderedHtml = function(){
			return this.renderedHtml;
		}

		Panel.prototype.getTitle = function(){return this.title;}

		var MedicalRecordDisplayPanel = function(data){
			for(key in data){
				this[key] = data[key];
			}
			this.init();
			this.render();
		}
		extend(MedicalRecordDisplayPanel, Panel);

		MedicalRecordDisplayPanel.prototype.render = function(){
			var record = this.record;
			this.renderedHtml = record.getRenderHtml();
		}

		MedicalRecordDisplayPanel.prototype.getMedicalRecord = function(){
			return this.record;
		}

		var PatientChartDispalyPanel = function(data){
			for(key in data){
				this[key] = data[key];
			}
			this.init();
			this.render();
		}
		extend(PatientChartDispalyPanel, Panel);

		PatientChartDispalyPanel.prototype.render = function(){
			var self = this,
				patient = this.patient,
				chartName = this.chartType.name;

			var promise = patient.getStatistic(chartName);
			promise.then(function(res){
				var html = renderChart(chartName, res[chartName]);
				self.renderedHtml = $sce.trustAsHtml(html);
			},function(e){
				self.renderedHtml = $sce.trustAsHtml('<div>加载失败</div>');
			});
		}

		var PatientChartType = function(data){
			this.name = data.name;
			this.displayName = data.displayName;
		}

		scope.viewingRecordPatient = null;
		scope.selectedPatient = null;
		scope.patients = [];
		scope.selectedRecord = null;
		scope.panels = []
		scope.activePanel = null;
		scope.patientFilter = null;

		scope.patientChartTypes = [
			new PatientChartType({'name': patientChartTypes.BLOOD_PRESSURE, 'displayName': '血压'}),
			new PatientChartType({'name': patientChartTypes.BODY_TEMPERATURE, 'displayName': '体温'}),
			new PatientChartType({'name': patientChartTypes.BLOOD_GLUCOSE, 'displayName': '血糖'}),
			new PatientChartType({'name': patientChartTypes.HEART_RATE, 'displayName': '心率'})
		];

		scope.getViewingRecordPatient = function(){
			return scope.viewingRecordPatient;
		}

		scope.setViewingRecordPatient = function(p){
			scope.viewingRecordPatient = p;
			if(p){
				p.loadRecords();
			}
		}
		
		scope.getViewingRecords = function(){
			if(scope.viewingRecordPatient){
				return scope.viewingRecordPatient.getMedicalRecords();
			}else{
				return [];
			}
		}

		scope.getPatients = function(){
			var patients = scope.patients || [];
			if(scope.patientFilter){
				var patientFilter = scope.patientFilter;

				patients = patients.filter(function(p){
					if(p.getName().indexOf(patientFilter) >= 0
						|| p.getUsername().indexOf(patientFilter) >= 0
						|| p.getGuid().indexOf(patientFilter) >= 0){
						return true;
					}else{
						return false;
					}
				});
			}
			return patients;
		}


		scope.getPanels = function(){
			return scope.panels || [];
		}

		scope.displayMedicalRecord = function(record){
			var existPanel = null;
			scope.getPanels().forEach(function(p){
				if(p instanceof MedicalRecordDisplayPanel && p.getMedicalRecord().id == record.id){
					existPanel = p;
				}
			});
			if(existPanel){
				scope.activatePanel(existPanel);
				return;
			}
			var newPanel = new MedicalRecordDisplayPanel({'record': record, 'title': record.getPatient().getName() + '-' + record.serial_number});
			scope.addPanel(newPanel);
		}

		scope.displayChart = function(patient, chartType){
			var existPanel = null;

			scope.getPanels().forEach(function(p){
				if(p instanceof PatientChartDispalyPanel && p.patient.id == patient.id && p.chartType == chartType){
					existPanel = p;
				}
			});
			if(existPanel){
				scope.activatePanel(existPanel);
				return;
			}

			var newPatientChartPanel = new PatientChartDispalyPanel({'patient': patient, 'chartType': chartType, 'title': patient.getName() + chartType.displayName});
			scope.addPanel(newPatientChartPanel);
		}

		scope.addPanel = function(panel){
			if(scope.panels.length >= 10){
				return alert('最多只能打开10个标签页');
			}
			if(scope.panels.indexOf(panel) < 0){
				scope.panels.push(panel);
				scope.activatePanel(panel);
			}
		}
		scope.isPanelActive = function(panel){
			return scope.activePanel === panel;
		}
		scope.activatePanel = function(panel){
			panel = panel || scope.getPanels()[0] || null;
			scope.activePanel = panel;
		}
		scope.dismissPanel = function(panel){
			var idx = scope.panels.indexOf(panel);
			if(idx >= 0){
				scope.panels.splice(idx, 1);
			}
		}

		scope.getPanelTitleWidth = function(){
			return $('#title-container').width() / (scope.getPanels().length + 1);
		}

		function init(){
			http.get(apiUrls.apiLoadPatients)
				.success(function(res){
					scope.patients = res.patients.map(function(p){
						return new Patient(p);
					});
				})
				.error(function(e){
					alert('初始化失败');
				});
		}

		scope.css = {
			'selected': function(v){
				if(v) return 'selected';
				else  return '';
			},
			'active': function(v){
				if(v) return 'active';
				else  return '';
			}
		}

		init();



		/**
		* Hacking area
		*/

		$('body').on('click', '.btn-add-comment', function(e){
			var btn = $(this),
				container = btn.parents('.comment-area-container'),
				recordId = container.data('record'),
				textInput = container.find('.comment-content'),
				commentContent = textInput.val();

			if(!commentContent){
				return alert('评论不能为空');
			}

			var recordPanel = scope.getPanels().filter(function(p){
				if(p instanceof MedicalRecordDisplayPanel && p.getMedicalRecord().id == recordId){
					return true;
				}else{
					return false;
				}
			})[0];

			if(!recordPanel){
				throw new Error('NO RECORD');
				return;
			}

			var data = {'medical_record_id': recordId, 'comment': commentContent};

			$.ajax({
				url: apiUrls.apiAddComment, 
				data: data,
				dataType: 'json',
				success: function(res){
					recordPanel.record.comments.push(res);
					recordPanel.render();
					if(!scope.$$phase){
						scope.$digest();
					}
				},
				error: function(){
					alert('操作失败，请检查网络或联系管理员');
				}
			});
		});
	}])
	.service('apiUrls', function(){
		return {
			apiLoadPatients: '/api/patients',
			apiLoadPatientRecords: '/api/medical_records',
			apiLoadPatientStatistic: '/api/patient/statistic',
			apiAddComment: '/api/medical_record/comment/add'
		}
	})
	.service('patientChartTypes', function(){
		return {
			BLOOD_PRESSURE: 'blood_pressure',
			BODY_TEMPERATURE: 'body_temperature',
			BLOOD_GLUCOSE: 'blood_glucose',
			HEART_RATE: 'heart_rate'
		}
	})
	.service('renderDiagnosis', function(){
		if(!window.swig){
			throw new Error('SWIG IS REQUIRED');
			return;
		}
		var templateStr = $('#render-diagnosis-template').html();
		var template = swig.compile(templateStr);
		return function(record){
			return template({'record': record}) + '<script>$(".img-thumbnail").fancybox();</script>';
		}
	})
	.service('uuid', function(){
		return function(){
	        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxx'.replace(/[xy]/g, function(c){
	            var r = Math.random()*16|0 , v = c == 'x' ? r : (r&0x3|0x8);
	            return v.toString(16);
	        }).toString();
	    }
	})
	.service('renderChart', ['uuid', 'patientChartTypes', function(uuid, patientChartTypes){
		/**
		* Takes two parameters
		* chartName: what data is presented in the chart: blood_pressure, body_temperature, heart_rate, blood_glucose
		* data: Depends on chartName,
		* - For blood_pressure, is a object: {"low": data point array, "high": data point array}
		* - Others: Just an array of data point, each element is {"time": Date object, "value": float value}
		*/
		return function(chartName, data){
			var htmlDom, htmlDomId, option;
			htmlDomId = uuid();
			htmlDom = '<div id="DOM_ID" style="height:400px;"></div>',
			hasData = true,
			htmlForNoData = '<div>暂时没有数据</div>';

			if(!data.length){
				return htmlForNoData;
			}

			// Only consider two weeks data
			var today = new Date(),
				twoWeeksAgo = new Date(today.getTime() - 3600 * 1000 * 24 * 14),
				minDay = getDays(twoWeeksAgo),
				maxDay = getDays(today);

			var chartTitle = null,
				legends = null,
				xAxisLabels = null,
				yAxisFormatter = null,
				series = null,
				seriesKeys = null;

			switch(chartName){
				case patientChartTypes.BLOOD_PRESSURE:
					chartTitle = '血压曲线';
					legends = ['血压(mmHg)-峰值', '血压(mmHg)-谷值'];
					yAxisFormatter = '{value}';
					seriesKeys = ['low', 'high'];
					break;
				case patientChartTypes.BODY_TEMPERATURE:
					chartTitle = '体温曲线';
					legends = ['体温(摄氏度）'];
					yAxisFormatter = '{value}';
					seriesKeys = ['value'];
					break;
				case patientChartTypes.BLOOD_GLUCOSE:
					chartTitle = '血糖曲线';
					legends = ['血糖'];
					yAxisFormatter = '{value}';
					seriesKeys = ['value'];
					break;
				case patientChartTypes.HEART_RATE:
					chartTitle = '心率曲线';
					legends = ['心率'];
					yAxisFormatter = '{value}';
					seriesKeys = ['value'];
					break;
				default:
					throw new Error('INVALID CHART');
					return '<div>曲线类型不合法</div>'
			}

			// data is a list of item {time: .., value: ...}
			data = data.map(function(d){
				var mapData = {time: new Date(d.time)};
				seriesKeys.forEach(function(seriesKey){
					mapData[seriesKey] = parseFloat(d[seriesKey]);
				});
				mapData.daysSince19700101 = getDays(mapData.time);
				return mapData;
			}).filter(function(d){
				var days = getDays(d.time);
				if(days <= maxDay && days >= minDay){
					return true;
				}else{
					return false;
				}
			});

			// Figure out which days' data is available
			var daysMap = {};
			data.forEach(function(d){
				if(daysMap[d.daysSince19700101]){
					seriesKeys.forEach(function(seriesKey){
						daysMap[d.daysSince19700101][seriesKey].push(d[seriesKey]);
					});
				}else{
					daysMap[d.daysSince19700101] = {date: new Date(d.daysSince19700101 * 3600 * 1000 * 24)};
					seriesKeys.forEach(function(seriesKey){
						daysMap[d.daysSince19700101][seriesKey] = [d[seriesKey]];
					});
				}
			});
			var days = [];
			for(key in daysMap){days.push(key);}

			days = days.sort(function(d1, d2){
				return d1 - d2;
			});

			xAxisLabels = days.map(function(d){
				return toDateString(daysMap[d].date);
			});

			if(chartName == patientChartTypes.BLOOD_PRESSURE){
				lowY = days.map(function(d){
					return average(daysMap[d].low);
				});

				highY = days.map(function(d){
					return average(daysMap[d].high);
				});

				series = [
			        {
			            name:'血压（高）',
			            type:'line',
			            itemStyle: {
			                normal: {
			                    lineStyle: {
			                        shadowColor : 'rgba(0,0,0,0.4)',
			                        shadowBlur: 5,
			                        shadowOffsetX: 3,
			                        shadowOffsetY: 3
			                    }
			                }
			            },
			            data: highY,
			            markPoint : {
			                data : [
			                    {type : 'max', name: '最大值'},
			                    {type : 'min', name: '最小值'}
			                ]
			            },
			            markLine : {
			                data : [
			                    {type : 'average', name: '平均值'}
			                ]
			            }
			        },
			        {
			            name:'血压（低）',
			            type:'line',
			            itemStyle: {
			                normal: {
			                    lineStyle: {
			                        shadowColor : 'rgba(0,0,0,0.4)',
			                        shadowBlur: 5,
			                        shadowOffsetX: 3,
			                        shadowOffsetY: 3
			                    }
			                }
			            },
			            data: lowY,
			            markPoint : {
			                data : [
			                    {type : 'max', name: '最大值'},
			                    {type : 'min', name: '最小值'}
			                ]
			            },
			            markLine : {
			                data : [
			                    {type : 'average', name: '平均值'}
			                ]
			            }
			        }
			    ]

			}else if(chartName == patientChartTypes.BODY_TEMPERATURE 
					|| chartName == patientChartTypes.BLOOD_GLUCOSE 
					|| chartName == patientChartTypes.HEART_RATE){
				
				Y = days.map(function(d){
					return average(daysMap[d].value);
				});

				series = [
			        {
			            name:'体温',
			            type:'line',
			            itemStyle: {
			                normal: {
			                    lineStyle: {
			                        shadowColor : 'rgba(0,0,0,0.4)',
			                        shadowBlur: 5,
			                        shadowOffsetX: 3,
			                        shadowOffsetY: 3
			                    }
			                }
			            },
			            data: Y,
			            markPoint : {
			                data : [
			                    {type : 'max', name: '最大值'},
			                    {type : 'min', name: '最小值'}
			                ]
			            },
			            markLine : {
			                data : [
			                    {type : 'average', name: '平均值'}
			                ]
			            }
			        }
			    ]
				       
			}


			option = {
			    title : {
			        text: chartTitle,
			    },
			    tooltip : {
			        trigger: 'axis'
			    },
			    legend: {
			        data: legends
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            mark : {show: true},
			            dataView : {show: true, readOnly: false},
			            magicType : {show: true, type: ['line', 'bar']},
			            restore : {show: true},
			            saveAsImage : {show: true}
			        }
			    },
			    calculable : true,
			    xAxis : [
			        {
			            type : 'category',
			            boundaryGap : false,
			            data : xAxisLabels
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value',
			            axisLabel : {
			                formatter: yAxisFormatter
			            },
			            splitArea : {show : true}
			        }
			    ],
			    series : series
			};          

			// Write to html
			var scriptHtml = '<script type="text/javascript">'
							 + 'var chartInstance = echarts.init(document.getElementById("DOM_ID"));'
							 + 'var option=' + JSON.stringify(option) + ';'
							 + 'chartInstance.setOption(option);'
			var html = (htmlDom + scriptHtml);
			html = html.replace('DOM_ID', htmlDomId).replace('DOM_ID', htmlDomId);
			return html;
		}

		/**
		* Some helper function
		*/
		function getDays(dateObj){
			return parseInt(dateObj.getTime() / 3600 / 1000 / 24);
		}

		function average(dataList){
			var sum = 0;
			dataList.forEach(function(v){
				sum += v;
			});
			return parseFloat(sum) / dataList.length;
		}

		function toDateString(dateObj){
			return dateObj.getFullYear() + '-' + (dateObj.getMonth() + 1) + '-' + dateObj.getDate();
		}
	}]);
