# puppet-zot

[![Tests](https://github.com/deric/puppet-zot/actions/workflows/test.yml/badge.svg)](https://github.com/deric/puppet-zot/actions/workflows/test.yml)

Puppet module to manage [zot registry](https://zotregistry.io/).

## Usage

Following code would start `zot` registry based on configuration values defined in [in Hiera common.yaml](./data/common.yaml).

```puppet
include zot
```

## Examples

Override installed version, see [zot releases](https://github.com/project-zot/zot/releases).
```yaml
zot::version: 2.0.0-rc7
```

Bind on all interfaces and port `80`
```yaml
zot::config:
  http:
    address: 0.0.0.0
    port: 80
```
Turn on debugging:
```yaml
zot::config:
  log:
    level: debug
```

Prometheus metrics:

```yaml
zot::config:
  extensions:
    metrics:
      enable: true
      prometheus:
        path: /metrics
```

Full example:
```yaml
---
zot::version: 1.4.3
zot::log_dir: /var/log/zot
zot::data_dir: /var/lib/zot
zot::config:
  distSpecVersion: 1.0.1
  storage:
    dedupe: true
    gc: true
    gcDelay: 1h
    gcInterval: 6h
  http:
    address: 0.0.0.0
    port: 443
    realm: zot
  log:
    level: info
  extensions:
    metrics:
      enable: true
      prometheus:
        path: /metrics
    search:
      enable: true
      cve:
        updateInterval: 24h
    sync:
      enable: true
      registries:
        - urls:
            - https://docker.io/library
          onDemand: true  # only requested images will be cached
          maxRetries: 3
          retryDelay: 5m
          pollInterval: 6h
    scrub:
      interval: 24h
    ui:
      enable: true

```

## Configuration

For full parameter reference see [the official documentation for the installed version](https://zotregistry.io/v1.4.3/admin-guide/admin-configuration/).

Change storage directory:
```yaml
zot::data_dir: /srv/zot
```

Change log directory:
```yaml
zot::log_dir: /srv/log
```

Puppet variables for documented in [REFERENCE.md](./REFERENCE.md).
