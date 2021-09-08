#!/bin/bash

latest_version=$(curl https://changelog.akeyless.io/ | grep -oP "(\d+\.+\d+\d+\.+\d)?(\d+\.+\d+\.+\d)" | head -n 1 )
current_version=$(grep -oP "(\d+\.+\d+\d+\.+\d)?(\d+\.+\d+\.+\d)" gateway-deployment.yaml | tail -1 )

if [ "$current_version"  == "$latest_version" ]; then
	echo "matches"
	exit 0
fi

sed -i "s/${current_version}/${latest_version}/g" gateway-deployment.yaml 
cat gateway-deployment.yaml 
