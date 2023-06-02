#!/usr/bin/env bash

mkdir -p "${JBOSS_HOME}"
unzip -d "/opt/sso" /tmp/artifacts/rh-sso-7.6.3-server-dist.zip
chown -R jboss:root "${JBOSS_HOME}"
