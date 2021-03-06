from utils import (get_command_output, logdbg, listen_on_https, behind_ssl_termination, get_conf, get_conf_bool, render_template, call)
import time
import os


def wait_for_nginx():
    while True:
        logdbg('waiting for nginx server to be ready')
        output = get_command_output('netstat -nltp')
        if ':80 ' in output:
            logdbg(output)
            logdbg('nginx is ready')
            return
        time.sleep(2)


def change_nginx_config(https = None):
    if https is None:
        https = listen_on_https()
        
    domain = get_conf('SEAFILE_SERVER_HOSTNAME', 'seafile.example.com')
    
    context = {
        'https': False,
        'behind_ssl_termination': behind_ssl_termination(),
        'domain': domain,
        'enable_webdav': get_conf_bool('ENABLE_WEBDAV')
    }
    if not os.path.isfile('/shared/nginx/conf/seafile.nginx.conf'):
        render_template('/templates/seafile.nginx.conf.template',
                        '/etc/nginx/sites-enabled/seafile.nginx.conf', context)

    call('nginx -s reload')
    time.sleep(2)

    
    
