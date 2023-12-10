# @summary Manage docker registry replacement (zot)
# @param version
#   Version to be fetched from github release page, without `v` prefix (see https://github.com/project-zot/zot/releases)
# @param binary
#   Main executable name, default: `zot`
# @param bin_path
#   Path for installing binaries, default: `/usr/bin`
# @param config
#   Main zot configuration, as multi-level hash (see README for more examples)
# @param defaults
#   Default values that would be overwritten by $config Hash
# @param user
#  Account running the service, default: `zot`
# @param group
#  Group owning service and config files, default: `zot`
# @param config_dir
#   Directory storing zot service configuration, default: `/etc/zot`
# @param log_dir
#   Directory used for storing log files
# @param data_dir
#   Directory used for storing registry data
# @param manage_service
#   Whether service should be managed by Puppet, default: `true`
# @param manage_config
#   Whether zot config should be managed by Puppet, default: `true`
# @param manage_zli
#   Whether zli binary should be installed, default: `true`
# @param service_name
# @param service_ensure
# @param service_enable
# @param download_mirror
#   URI used for downloading zot binaries
# @param arch
#   Release architecture, eiter `amd64` or `arm64`. Default: `amd64`
# @param os
#   Used for downloading precompiled binary for given OS, default: `linux`
# @param uid
#   User account UID
# @param gid
#   Group ID
# @param limit_nofile
#   Limit number of opened files for systemd service, default: `500000`
# @see https://zotregistry.io/
# @example
#   include zot
# @example
#   # using Puppet code
#   class { 'zot':
#     config => {
#        'http' => {
#           'port' => 80,
#        }
#     }
#   }
class zot (
  Zot::Config       $config,
  Zot::Config       $defaults,
  String            $version,
  String            $binary,
  Stdlib::Unixpath  $bin_path,
  String            $user,
  String            $group,
  String            $service_name,
  String            $service_ensure,
  Boolean           $service_enable,
  Stdlib::Unixpath  $config_dir,
  Stdlib::Unixpath  $log_dir,
  Stdlib::Unixpath  $data_dir,
  Boolean           $manage_service,
  Boolean           $manage_config,
  Boolean           $manage_zli,
  Stdlib::HTTPUrl   $download_mirror,
  Zot::Arch         $arch,
  Zot::Os           $os,
  Integer           $limit_nofile,
  Optional[Integer] $uid = undef,
  Optional[Integer] $gid = undef,
) {
  contain zot::install
  contain zot::config
  contain zot::service
}
