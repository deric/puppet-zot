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

Change storage directory:
```yaml
zot::data_dir: /srv/zot
```

## Configuration

For full parameter reference see [the official documentation for the installed version](https://zotregistry.io/v1.4.3/admin-guide/admin-configuration/).
