1. `docker build -t djangotracetest .`
2. `docker run --rm  -p 8000:8000 -it djangotracetest`

If signalfx agent is running on local host, you can run the agent docker container and above container in the same network by passing `--network <network-name>` to both docker run commands. 

