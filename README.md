# docker-dev

My minimal dev environment in a Docker container

## Usage

### Pull from Dockerhub

```
docker pull vipul20/docker-dev:latest
docker run -d --name=docker-dev -it vipul20/docker-dev:latest
docker exec -it docker-dev zsh
```

### Manual

```
docker build . -t docker-dev
docker run -d --name=docker-dev -it docker-dev
docker exec -it docker-dev zsh
```

## License

MIT

