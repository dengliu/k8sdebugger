# k8sdebugger
A containerized toolbox for debugging kubernetes inspired by [netshoot](https://github.com/nicolaka/netshoot) and [doks-debug](https://github.com/digitalocean/doks-debug)

## Build and push k8sdebugger image on multiple platforms
```shell
docker buildx build --platform linux/amd64,linux/arm64 -f docker/k8sdebugger.Dockerfile -t dengliu/k8sdebugger:latest --push .
```

## Troubleshoot Network Problems

k8sdebugger offers a set of tools as recommended by this diagram

![img.png](img.png)
