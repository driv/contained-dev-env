#!/bin/bash

if [ "$#" -ne 1 ]; then
	>&2 echo "USAGE: $(basename "$0") recipe";
	exit 1;
fi;
recipefile=$1.env

if [ ! -f "$recipefile" ]; then
	>&2 echo "$recipefile does not exist";
	exit 1;
fi;
source "$recipefile";
image=${image?"No image defined in recipe"};
aliases=${aliases?"No aliases defined in recipe"};

container_name=$image"_env"

docker run -d --name "$container_name" "$image" tail -f /dev/null

base_command="docker exec -i $container_name"

aliases_list=$(echo "$aliases" | tr "," "\n");

for alias in $aliases_list
do
    alias "$alias=$base_command $alias";
done
