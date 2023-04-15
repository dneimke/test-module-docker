# test-module-docker
An example showing how to use Docker for inner and outer loop development

## Getting started

- `.\tools\local-dependencies.ps1` installs the dev-dependencies
- `.\tools\local-test.ps1` publishes the module and runs Pester tests
- `.\Consumers\Invoke-EchoConsumer` - run this command to test the module as a consumer

## Docker

Build the image:

```cmd
docker build --pull --rm -f "Dockerfile" -t testmoduledocker:latest "."
```

Runs a container and automatically removes it on exit. The `-it` flag instructs docker to allocate a pseudo-TTY connected to the container’s stdin; creating an interactive bash shell in the container.

```cmd
docker run --rm -it testmoduledocker:latest
```

With the docker container running, navigate to `.\ps-consumers` in the interactive terminal and run the test command:

```cmd
.\Invoke-EchoConsumer.ps1
```