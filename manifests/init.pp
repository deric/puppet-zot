# @summary Manage docker registry replacement (zot)
# @param version
#   Without `v` prefix
# @param binary
#   path to the main executable
# @param config
#   Main zot configuration,
# @param defaults
#   Default values that would be overwritten by $config Hash
# @param user
# @param group
# @param config_dir
# @param log_dir
# @param data_dir
# @param manage_service
# @param service_name
# @param service_ensure
# @param service_enable
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
  Hash             $config,
  Hash             $defaults,
  String           $version,
  Stdlib::Unixpath $binary,
  String           $user,
  String           $group,
  String           $service_name,
  String           $service_ensure,
  Boolean          $service_enable,
  Stdlib::Unixpath $config_dir,
  Stdlib::Unixpath $log_dir,
  Stdlib::Unixpath $data_dir,
  Boolean          $manage_service,
) {
  contain zot::install
  contain zot::config
  contain zot::service
}
