- [Tasks](#tasks)
- [extensions](#extensions)
- [settings.json](#settingsjson)
- [remote-ssh](#remote-ssh)
- [Cloud IDE](#cloud-ide)

# Tasks
- Regex - deleting empty lines: ^\s*$\n
- Command Palette: F1 / Ctrl+Shift+P
- Search Settings: Ctrl+, ==> search "XXX.YYY"
- github to web vscode: add "1s" in URL # https://github.com/conwnet/github1s

# extensions
- yzhang.markdown-all-in-one | https://github.com/yzhang-gh/vscode-markdown
    - TOC Indent: https://github.com/yzhang-gh/vscode-markdown/blob/master/CHANGELOG.md#200-20190119

            "markdown.extension.list.indentationSize": "inherit",  # tab size setting of current file
    
- shardulm94.trailing-spaces   # F1 => Trailing Spaces: Delete
- mhutchie.git-graph

# settings.json

    "editor.renderWhitespace": "all",
    "git.path": "D:\\sdk\\Git\\bin\\git.exe",
    "markdown.editor.pasteUrlAsFormattedLink.enabled": "never",
    "editor.detectIndentation": false,

# remote-ssh
https://code.visualstudio.com/docs/remote/ssh  
extension: ms-vscode-remote.remote-ssh

    "remote.SSH.configFile": "D:\\conf\\ssh_config"

    Host 192.168.88.72
        HostName 192.168.88.72
        IdentityFile C:/Users/root/.ssh/id_rsa  <== File permission: current user only
        User root

F1 => Remote-SSH: Connect to Host...

# Cloud IDE
https://theia-ide.org/docs/