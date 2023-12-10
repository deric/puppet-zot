# @summary Zot service
# @api private
class zot::service (
  String $service_name = $zot::service_name,
) {
  if $zot::manage_service {
    $zot_binary = "${zot::bin_path}/${zot::binary}"
    systemd::unit_file { "${service_name}.service":
      content => epp("${module_name}/zot.service.epp", {
          'binary'       => $zot_binary,
          'user'         => $zot::user,
          'group'        => $zot::group,
          'config_file'  => $zot::config::path,
          'limit_nofile' => $zot::limit_nofile,
          'memory_high'  => $zot::memory_high,
          'memory_max'   => $zot::memory_max,
      }),
      active  => true,
      enable  => $zot::service_enable,
      require => File[$zot_binary],
    }

    service { $service_name:
      ensure    => $zot::service_ensure,
      enable    => $zot::service_enable,
      subscribe => [File[$zot_binary]],
    }

    if $zot::manage_config {
      Service<| title == $service_name |> {
        subscribe => [File[$zot_binary], File[$zot::config::path]],
      }
    }
  }
}
