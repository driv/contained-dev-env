source recipe.env

container_name=$image"_env"

docker run -d --name $container_name $image tail -f /dev/null

base_command="docker exec -i $container_name"

aliases_list=$(echo $aliases | tr "," "\n");

for alias in $aliases_list
do
    alias $alias="$base_command $alias";
done