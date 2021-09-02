#!/bin/bash

latest_version=$(curl https://changelog.akeyless.io/ | grep -oP "(\d+\.+\d+\d+\.+\d)?(\d+\.+\d+\.+\d)" | head -n 1 )
current_version=$(grep -oP "(\d+\.+\d+\d+\.+\d)?(\d+\.+\d+\.+\d)" kube_original.yaml | tail -1 )

if [ "$current_version | base64"  == "$latest_version | base64" ]; then
	echo "matches"
	exit 0
fi

sed -i "s/${current_version}/${latest_version}/g" kube_original.yaml
cat kube_original.yaml
