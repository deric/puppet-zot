# @summary Manages configuration
# @api private
class zot::config (
  String $user = $zot::user,
  String $group = $zot::group,
  Stdlib::Unixpath $path = "${zot::config_dir}/config.json"
) {
  $_conf = deep_merge($zot::defaults, {
      'storage' => {
        'rootDirectory' => $zot::data_dir,
      },
      'log' => {
        'output' => "${zot::log_dir}/zot.log",
        'audit' => "${zot::log_dir}/zot-audit.log",
      }
  })

  $config = deep_merge($_conf, $zot::config)

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
