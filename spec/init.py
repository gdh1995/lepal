from fp_tools.proxy import proxy
from config import HOST

if __name__ == '__main__':
	proxy(HOST + '/api/init', 'GET')
	