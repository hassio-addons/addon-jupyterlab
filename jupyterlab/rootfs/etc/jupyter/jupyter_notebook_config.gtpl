# Configuration file for ipython-notebook.

c = get_config()

# ------------------------------------------------------------------------------
# NotebookApp configuration
# ------------------------------------------------------------------------------

c.GitHubConfig.access_token = '{{ .token }}'
c.JupyterApp.answer_yes = True
c.LabApp.user_settings_dir = '/data/user-settings'
c.LabApp.workspaces_dir = '/data/workspaces'
c.NotebookApp.allow_origin = '*'
c.NotebookApp.allow_password_change = False
c.NotebookApp.allow_remote_access = True
c.NotebookApp.allow_root = True
c.NotebookApp.base_url = '{{ .entry }}'
c.NotebookApp.ip = '127.0.0.1'
c.NotebookApp.notebook_dir = '/config/notebooks'
c.NotebookApp.open_browser = False
c.NotebookApp.password = ''
c.NotebookApp.port = 28459
c.NotebookApp.token = ''
c.NotebookApp.tornado_settings = {'static_url_prefix': '/static/'}
c.NotebookApp.trust_xheaders = True
c.NotebookApp.tornado_settings = {
    'headers': {
        'Content-Security-Policy': "frame-ancestors *"
    }
}
