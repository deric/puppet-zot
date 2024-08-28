# Changelog

All notable changes to this project will be documented in this file.

## Release 2.1.0 [2024-06-25]

- Support `puppet/systemd` 7.x
- Drop Debian 10

## Release 2.0.0 [2024-06-25]

- Use `stdlib::to_json_pretty` (require `puppetlabs::stdlib` >= `9.0.0`)
- Fix min dependency `puppet/archive` >= `7.0.0`

## Release 1.2.0 [2024-01-15]

 Upgrade to zot registry 2.0.0 by default

## Release 1.1.0 [2023-12-12]

  Optional user management

## Release 1.0.0 [2023-12-10]

**Features**

  Inital (feature complete) release.

  Module manages `zot` registry service and serializes configuration from yaml to JSON that is supplied to the service.

