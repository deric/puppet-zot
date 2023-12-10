# @summary Manage docker registry replacement (zot)
# @param version
#   Version to be fetched from github release page, without `v` prefix (see https://github.com/project-zot/zot/releases)
# @param binary
#   Path to the main executable
# @param config
#   Main zot configuration, as multi-level hash (see README for more examples)
# @param defaults
#   Default values that would be overwritten by $config Hash
# @param user
#  Account running the service
# @param group
#  Group owning service and config files
# @param config_dir
#   Directory storing zot service configuration
# @param log_dir
#   Directory used for storing log files
# @param data_dir
#   Directory used for storing registry data
# @param manage_service
#   Whether service should be managed by Puppet
# @param service_name
# @param service_ensure
# @param service_enable
# @param download_mirror
#   URI used for downloading zot binaries
# @param uid
#   User account UID
# @param gid
#   Group ID
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
  Hash              $config,
  Hash              $defaults,
  String            $version,
  Stdlib::Unixpath  $binary,
  String            $user,
  String            $group,
  String            $service_name,
  String            $service_ensure,
  Boolean           $service_enable,
  Stdlib::Unixpath  $config_dir,
  Stdlib::Unixpath  $log_dir,
  Stdlib::Unixpath  $data_dir,
  Boolean           $manage_service,
  Stdlib::HTTPUrl   $download_mirror,
  Optional[Integer] $uid = undef,
  Optional[Integer] $gid = undef,
) {
  contain zot::install
  contain zot::config
  contain zot::service
}
