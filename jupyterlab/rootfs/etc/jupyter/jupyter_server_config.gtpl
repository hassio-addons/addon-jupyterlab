# Configuration file for ipython-notebook.

c = get_config()

# ------------------------------------------------------------------------------
# NotebookApp configuration
# ------------------------------------------------------------------------------

c.GitHubConfig.access_token = '{{ .token }}'
c.JupyterApp.answer_yes = True
c.LabApp.user_settings_dir = '/data/user-settings'
c.LabApp.workspaces_dir = '/data/workspaces'
c.ServerApp.allow_origin = '*'
c.ServerApp.allow_password_change = False
c.ServerApp.allow_remote_access = True
c.ServerApp.allow_root = True
c.ServerApp.base_url = '{{ .entry }}'
c.ServerApp.ip = '127.0.0.1'
c.ServerApp.root_dir = '/config/notebooks'
c.ServerApp.open_browser = False
c.ServerApp.password = ''
c.ServerApp.port = 28459
c.ServerApp.token = ''
c.ServerApp.tornado_settings = {'static_url_prefix': '/static/'}
c.ServerApp.trust_xheaders = True
c.ServerApp.tornado_settings = {
    'headers': {
        'Content-Security-Policy': "frame-ancestors *"
    }
}
