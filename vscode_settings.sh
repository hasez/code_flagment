#/bin/sh

# for win
# setting_json="%APPDATA%\Code\User\settings.json"
# for mac
setting_json="$HOME/Library/Application Support/Code/User/settings.json"
# for linux
# setting_json="$HOME/.config/Code/User/settings.json"


cat <<EOF >> $setting_json
    "terminal.integrated.env.linux": {
        "PJ_HOME": "${workspaceFolder}"
    },
    "terminal.integrated.env.osx": {
        "PJ_HOME": "${workspaceFolder}"
    },
    "terminal.integrated.env.windows": {
        "PJ_HOME": "${workspaceFolder}"
    },
EOF
