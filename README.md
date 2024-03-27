# k8sdebugger
A containerized toolbox for debugging kubernetes

### Build and push k8sdebugger image
```shell
docker buildx build --platform linux/amd64,linux/arm64 -f docker/k8sdebugger.Dockerfile -t dengliu/k8sdebugger:latest --push .
```
