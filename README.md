# ephemeral
Kubernetes ephemeral containers
docker run --rm -it $(docker build -q --no-cache -t grefeos/ephemeral:`date '+%y%m%d%H%M'` -t grefeos/ephemeral:latest .)