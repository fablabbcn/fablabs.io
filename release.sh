# Build and publish image to DOCKER HUB

set -ex
USERNAME=fablabbarcelona
IMAGE=fablabsio
version=`cat VERSION`

echo "VERSION: $version"

docker build -t $USERNAME/$IMAGE:latest .
docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$version
docker push $USERNAME/$IMAGE:latest
docker push $USERNAME/$IMAGE:$version
