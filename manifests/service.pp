# @summary zot service
# @api private
class zot::service {
  if $zot::manage_service {
    systemd::unit_file { 'zot.service':
      content => epp("${module_name}/zot.service.epp", {
          'binary'      => $zot::binary,
          'user'        => $zot::user,
          'group'       => $zot::group,
          'config_file' => $zot::config::path,
      }),
      enable  => true,
      active  => true,
      require => Archive[$zot::binary],
    }
  }
}
