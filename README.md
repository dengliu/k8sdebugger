# k8sdebugger
A containerized toolbox for debugging kubernetes inspired by [netshoot](https://github.com/nicolaka/netshoot) and [doks-debug](https://github.com/digitalocean/doks-debug)

## Container Images

Available on multiple registries with multi-architecture support (AMD64/ARM64):

- **Docker Hub**: [dengliu/k8sdebugger](https://hub.docker.com/r/dengliu/k8sdebugger)
- **GitHub Container Registry**: [ghcr.io/dengliu/k8sdebugger](https://github.com/dengliu/k8sdebugger/pkgs/container/k8sdebugger)

## Build and Push Multi-Architecture Images

### Prerequisites

1. Set up Docker buildx for multi-platform builds:
```shell
docker buildx create --name multiarch --use --bootstrap
```

2. Authenticate with registries:

**For GitHub Container Registry (GHCR):**
```shell
# Create a GitHub Personal Access Token with 'write:packages' and 'read:packages' permissions
echo $GITHUB_TOKEN | docker login ghcr.io -u <your-github-username> --password-stdin
```

**For Docker Hub:**
```shell
docker login
```

### Build Multi-Architecture Images

Build for both AMD64 and ARM64 platforms without pushing:
```shell
docker buildx build --platform linux/amd64,linux/arm64 -f docker/k8sdebugger.Dockerfile -t k8sdebugger:latest .
```

### Publish to GitHub Container Registry (GHCR)

```shell
# Build and push to GHCR
docker buildx build --platform linux/amd64,linux/arm64 \
  -f docker/k8sdebugger.Dockerfile \
  -t ghcr.io/dengliu/k8sdebugger:latest \
  -t ghcr.io/dengliu/k8sdebugger:$(git rev-parse --short HEAD) \
  --push .
```

### Publish to Docker Hub

```shell
# Build and push to Docker Hub
docker buildx build --platform linux/amd64,linux/arm64 \
  -f docker/k8sdebugger.Dockerfile \
  -t dengliu/k8sdebugger:latest \
  -t dengliu/k8sdebugger:$(git rev-parse --short HEAD) \
  --push .
```

### Publish to Both Registries

```shell
# Build and push to both GHCR and Docker Hub simultaneously
docker buildx build --platform linux/amd64,linux/arm64 \
  -f docker/k8sdebugger.Dockerfile \
  -t ghcr.io/dengliu/k8sdebugger:latest \
  -t ghcr.io/dengliu/k8sdebugger:$(git rev-parse --short HEAD) \
  -t dengliu/k8sdebugger:latest \
  -t dengliu/k8sdebugger:$(git rev-parse --short HEAD) \
  --push .
```

### Usage

Pull and run the image from either registry:

**From GHCR:**
```shell
docker run -it --rm ghcr.io/dengliu/k8sdebugger:latest
```

**From Docker Hub:**
```shell
docker run -it --rm dengliu/k8sdebugger:latest
```

## Troubleshoot Network Problems

k8sdebugger offers a set of tools as recommended by this diagram

![img.png](img.png)
