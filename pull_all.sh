#! /bin/bash
#
# Pull all docker images from a private registry
#
#



username=''
passwd=''
docker_registry_url=''
tag=''
docker login -u $username -p $passwd $docker_registry_url
curl "https://$username:$passwd@$docker_registry_url/v2/_catalog" | jq -c '.[][]' | while read images; do
        for i in $images
        do
                img=$(echo $i | tr -d '"')
                img_url=$(echo "$docker_registry_url/$img:$tag")
                echo "Pulling image $img_url"
                docker pull $img_url
        done
done
