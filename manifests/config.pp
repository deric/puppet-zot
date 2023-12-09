# @summary Manages configuration
# @api private
class zot::config (
  String $user = $zot::user,
  String $group = $zot::group,
  Stdlib::Unixpath $path = "${zot::config_dir}/config.json"
) {
  $config = $zot::config

  user { $user:
    ensure => present,
  }

  group { $group:
    ensure => present,
  }

  file { $zot::config_dir:
    ensure => directory,
    owner  => $user,
    group  => $group,
  }

  file { $zot::log_dir:
    ensure => directory,
    owner  => $user,
    group  => $group,
  }

  file { $zot::data_dir:
    ensure => directory,
    owner  => $user,
    group  => $group,
  }

  file { $path:
    ensure  => file,
    content => inline_epp('<%= $config.to_json_pretty %>', {
        'config' => $config,
    }),
    owner   => $user,
    group   => $group,
  }
}
