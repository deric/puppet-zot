# @summary zot service
# @api private
class zot::service (
  String $service_name = $zot::service_name,
) {
  if $zot::manage_service {
    systemd::unit_file { "${service_name}.service":
      content => epp("${module_name}/${service_name}.service.epp", {
          'binary'      => $zot::binary,
          'user'        => $zot::user,
          'group'       => $zot::group,
          'config_file' => $zot::config::path,
      }),
      active  => true,
      enable  => $zot::service_enable,
      require => Archive[$zot::binary],
    }

    service { $zot::service_name:
      ensure    => $zot::service_ensure,
      enable    => $zot::service_enable,
      subscribe => File[$zot::config::path],
    }
  }
}
