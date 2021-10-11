#!/bin/bash

manifest_path=kube-manifests/gateway/gateway-deployment.yaml
latest_version=$(curl https://changelog.akeyless.io/ | grep -oP "(\d+\.+\d+\d+\.+\d)?(\d+\.+\d+\.+\d)" | head -n 1 )
current_version=$(grep -oP "(\d+\.+\d+\d+\.+\d)?(\d+\.+\d+\.+\d)" $manifest_path | tail -1 )

latest_tag_version=$(curl https://hub.docker.com/v2/repositories/akeyless/base/tags | grep -oP "(\d+\.+\d+\.+\d\-+)|(\d+\.+\d+\.+\d)" | grep '[^-]$' | head -n 1)

current_tag_version=$(grep -oP "(\d+\.+\d+\d+\.+\d)?(\d+\.+\d+\.+\d)" $manifest_path | head -n 1)


if [ "$current_version" -ne "$latest_version" || "$current_tag_version" -ne "$latest_tag_version" ]; then
    sed -e "s/${current_tag_version}/${latest_tag_version}/g" $manifest_path
    sed -i "s/${current_version}/${latest_version}/g" $manifest_path
fi
