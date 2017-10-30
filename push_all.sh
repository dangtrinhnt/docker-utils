#! /bin/bash
#
# This will push all the images from a local registry to DockerHub. For example:
# local_registry_domain/branch/image_name:my-tag -> docker_hub_username/image_name:my-tag
#

dh_username=''
dh_passwd=''
local_repo=''
local_branch=''
local_repo_path="$local_repo/$local_branch/"
local_tag=''
docker login -u $dh_username -p $dh_passwd

# list local images
local_images=$(docker images "$local_repo_path*" --format "{{.Repository}}")
for i in $local_images
do
        img_name=${i//$local_repo_path/''}
        old_tag="$i:$local_tag"
        new_tag="$dh_username/$img_name:$local_tag"

        # tag the image to match dockerhub repo
        docker tag $old_tag $new_tag
        # push the image to docker
        docker push $new_tag
done
