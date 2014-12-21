'use strict';
module.exports = function(grunt) {

  // Load grunt tasks automatically
  require('load-grunt-tasks')(grunt);

  // Project configuration.
  grunt.initConfig({

    // Project settings
    app: {
      // configurable paths
      devPath: 'assets',
      buildPath: 'build',
      testPath: 'test',
      serverPath: '..'
    },

    // Empties dist folders before build.
    clean: {
      build: ['<%= app.buildPath %>/*']
    },

    karma: {
      unit: {
        configFile: 'karma.conf.js',
        options: {
          files: [
            '<%= app.devPath %>/bower_components/fiber/src/fiber.js',
            '<%= app.devPath %>/bower_components/jquery/dist/jquery.js',
            '<%= app.devPath %>/bower_components/angular/angular.js',
            '<%= app.devPath %>/bower_components/angular-mocks/angular-mocks.js',
            '<%= app.devPath %>/js/**/*.js',
            '<%= app.testPath %>/unit/**/*.js'
          ]
        },
        autoWatch: true
      }
    },

    // Allow us to run shell command
    shell: {                                // Task
        startServer: {                      // Target
            options: {},
            command: 'python <%= app.serverPath %>/manage.py runserver'
        },
        bowerInstall: {
          options: {},
          command: 'bower install'
        }
    },

    compass: {
      prod: {
        options: {
          httpPath: '/static/<%= app.buildPath %>/',
          sassDir: '<%= app.devPath %>/sass',
          cssDir: '<%= app.buildPath %>/stylesheets',
          imagesDir: '<%= app.buildPath %>/img',
          outputStyle: 'compressed'

        }
      },
      dev: {
        options: {
          httpPath: '/static/<%= app.buildPath %>/',
          sassDir: '<%= app.devPath %>/sass',
          cssDir: '<%= app.buildPath %>/stylesheets',
          imagesDir: '<%= app.buildPath %>/img',
          outputStyle: 'expanded'

        }
      }
    },

    watch: {
      css: {
          files: ['<%= app.devPath %>/sass/**/*.scss'],
          tasks: ['compass:dev']
      },
      js: {
          files: ['<%= app.devPath %>/js/**/*.js'],
          tasks: ['concat:dev']
      },
    },

    open : {
      dev : {
        path: 'http://127.0.0.1:8000/exam/preview',
        app: 'Google Chrome'
      }
    },

    uglify: {
      options: {
        mangle: false
      },
      // Uglify all js file and put them into one file in build folder.
      build: {
          files: {
              '<%= app.buildPath %>/js/all.js': ['<%= app.devPath %>/js/**/*.js']
          }
      }
    },

    concat: {
      options: {
        separator: ';',
      },
      dev: {
        files: {
          '<%= app.buildPath %>/js/all.js' : [
            '<%= app.devPath %>/bower_components/fiber/src/fiber.js',
            '<%= app.devPath %>/bower_components/angular/angular.js',
            '<%= app.devPath %>/bower_components/angular-sanitize/angular-sanitize.js',
            '<%= app.devPath %>/bower_components/angular-xeditable/dist/js/xeditable.js',
            '<%= app.devPath %>/bower_components/angular-bootstrap/ui-bootstrap-tpls.js',
            '<%= app.devPath %>/lib/ueditor/editor_config.js',
            '<%= app.devPath %>/lib/ueditor/editor_all.js',
            '<%= app.devPath %>/js/**/*.js'
          ]
        }
      },
      // Concat all js lib file infront of the already uglified js app file.
      build: {
        files: {
          '<%= app.buildPath %>/js/all.js' : [
            '<%= app.devPath %>/bower_components/fiber/src/fiber.min.js',
            '<%= app.devPath %>/bower_components/angular/angular.min.js',
            '<%= app.devPath %>/bower_components/angular-sanitize/angular-sanitize.min.js',
            '<%= app.devPath %>/bower_components/angular-xeditable/dist/js/xeditable.min.js',
            '<%= app.devPath %>/bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js',
            '<%= app.devPath %>/lib/ueditor/editor_config.js',
            '<%= app.devPath %>/lib/ueditor/editor_all_min.js',
            // Assumed it is uglified first
            '<%= app.buildPath %>/js/all.js'
          ]
        }
      }
    },

    // Copy folders and files to a different folders/files.
    copy: {
      // Copty all img files into build folder
      img: {
        files: [
          {expand: true, cwd: '<%= app.devPath %>/', src: ['img/**'], dest: '<%= app.buildPath %>'}
        ]
      }
    }
  });

  // This option builds the application in production style with minified css and js.
  grunt.registerTask('build', ['clean:build', 'shell:bowerInstall', 'compass:prod', 'uglify:build', 'concat:build', 'copy:img']);

  // Runs server
  grunt.registerTask('server', ['shell:startServer']);

  // Runs all unit test.
  grunt.registerTask('test', ['karma:unit']);

  // Copy img folder recrusively from dev path to build path.
  grunt.registerTask('img', ['copy:img']);

  // Run this command when devleoping. It builds up a clean build folder in dev style and start
  // watching all js, css files for changes.
  grunt.registerTask('devbuild', ['clean:build', 'shell:bowerInstall', 'compass:dev', 'concat:dev', 'copy:img']);

  grunt.registerTask('dev', ['clean:build', 'shell:bowerInstall', 'compass:dev', 'concat:dev', 'copy:img', 'watch']);
};
