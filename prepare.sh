#!/bin/sh
set -xe
env
apk update
apk upgrade
apk add python3
apk add python3-dev musl-dev gcc libffi-dev openssl-dev
pip3 install errbot
pip3 install "kubernetes$CLIENT_VER"
pip3 install sleekxmpp pyasn1 pyasn1-modules irc hypchat \
  slackclient python-telegram-bot prometheus_client

apk del musl-dev gcc libffi-dev --purge

cat >> /usr/local/bin/entry.sh << EOF
#!/bin/sh
if [ ! -f /errbot/config.py ]; then
    errbot --init
fi
errbot
EOF

chmod a+x /usr/local/bin/entry.sh

# Remove all
