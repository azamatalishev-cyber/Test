#!/bin/bash
file_path=gateway-deployment.yaml
latest_version=$(curl https://changelog.akeyless.io/ | grep -oP "(\d+\.+\d+\d+\.+\d)?(\d+\.+\d+\.+\d)" | head -n 1 )
current_version=$(grep -oP "(\d+\.+\d+\d+\.+\d)?(\d+\.+\d+\.+\d)" $file_path | tail -1 )

if [ "$current_version"  == "$latest_version" ]; then
	echo "matches"
	exit 0
fi

sed -i "s/${current_version}/${latest_version}/g" $file_path 
cat $file_path
