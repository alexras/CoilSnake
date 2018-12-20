# Running CoilSnake in Docker

## Building the Docker image

```
docker build -t coilsnake .
```

## Running the Docker image

```
xhost + 127.0.0.1 && docker run --rm -it -v <your working directory here>:/work -e DISPLAY=host.docker.internal:0 coilsnake
```
