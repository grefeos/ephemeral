# ephemeral
Kubernetes ephemeral containers
docker run --rm -it $(docker build -q --no-cache -t grefeos/ephemeral:`date '+%y%m%d%H%M'` -t grefeos/ephemeral:latest --platform linux/arm64,linux/amd64 .)

Debug build 
docker run --rm -it $(docker build -q --no-cache .)

docker build --no-cache --target ubuntu2vim2xrdp .

docker run --rm -it -p 3389:3389 $(docker build -q --target ubuntu2vim2xrdp2kde .) qwe qwe yes