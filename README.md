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

Bind on all interfaces and port `8080`
```yaml
zot::config:
  http:
    address: 0.0.0.0
    port: 8080
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
  http:
    address: 0.0.0.0
    port: 5000
    realm: zot
    tls:
      cert: /etc/letsencrypt/live/my.registry/fullchain.pem
      key: /etc/letsencrypt/live/my.registry/privkey.pem
  storage:
    dedupe: true
    gc: true
    gcDelay: 1h
    gcInterval: 6h
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

retention:
```yaml
zot::data_dir: /tmp/zot
zot::config:
  distSpecVersion: 1.1.0-dev
  storage:
    gc: true
    gcDelay: 2h
    gcInterval: 1h
    retention:
      dryRun: false
      delay: 24h
      policies:
        - repositories:
            - infra/*
            - prod/*
          deleteReferrers: false
          keepTags:
            - patterns:
                - v2.*
                - .*-prod
            - patterns:
                - v3.*
                - .*-prod
              pulledWithin: 168h
        - repositories:
            - tmp/**
          deleteReferrers: true
          deleteUntagged: true
          keepTags:
            - patterns:
                - v1.*
              pulledWithin: 168h
              pushedWithin: 168h
        - repositories:
            - '**'
          deleteReferrers: true
          deleteUntagged: true
          keepTags:
            - mostRecentlyPushedCount: 10
              mostRecentlyPulledCount: 10
              pulledWithin: 720h
              pushedWithin: 720h
    subPaths:
      /a:
        rootDirectory: /tmp/zot1
        dedupe: true
        retention:
          policies:
            - repositories:
                - infra/*
                - prod/*
              deleteReferrers: false
  http:
    address: 127.0.0.1
    port: 8080
  log:
    level: debug
```

## Configuration

For full parameter reference see [the official documentation for the installed version](https://zotregistry.io/v1.4.3/admin-guide/admin-configuration/). This module doesn't attempt to validate registry config specification. Merged configuration is serialized to JSON which will be syntactically correct but the config should be validated against `distSpecVersion` using e.g. `zot verify /etc/zot/config.json`.

Change storage directory:
```yaml
zot::data_dir: /srv/zot
```

Change log directory:
```yaml
zot::log_dir: /srv/log
```

In order to bind the `zot` service on ports < 1024, you'll need either `root` priviledges or configure bind capabilities, e.g. using [file_capability](https://github.com/smoeding/puppet-file_capability)

```yaml
file_capability::file_capabilities:
  "/usr/bin/zot-%{alias('zot::version')}":
    ensure: present
    capability: 'cap_net_bind_service=eip'
```

All Puppet variables are documented in [REFERENCE.md](./REFERENCE.md).
