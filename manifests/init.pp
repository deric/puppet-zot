# @summary Manage docker registry replacement (zot)
# @param version
#   Without `v` prefix
# @param binary
#    path to the main executable
# @param user
# @param group
# @param config_dir
# @param log_dir
# @param data_dir
# @see https://zotregistry.io/
class zot (
  Hash             $config = {},
  String           $version,
  Stdlib::Unixpath $binary,
  String           $user,
  String           $group,
  Stdlib::Unixpath $config_dir,
  Stdlib::Unixpath $log_dir,
  Stdlib::Unixpath $data_dir,
  Boolean          $manage_service,
) {
  contain zot::install
  contain zot::config
  contain zot::service
}
