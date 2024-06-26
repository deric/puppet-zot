# @summary Manages configuration, merges Puppet hashes and serialized them into JSON config
# @api private
class zot::config (
  String $user = $zot::user,
  String $user_ensure = $zot::user_ensure,
  String $group = $zot::group,
  Stdlib::Unixpath $path = "${zot::config_dir}/config.json"
) {
  if $zot::manage_user {
    user { $user:
      ensure     => $user_ensure,
      managehome => true,
      uid        => $zot::uid,
    }

    group { $group:
      ensure => $user_ensure,
      gid    => $zot::gid,
    }
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

  if $zot::manage_config {
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

    file { $path:
      ensure  => file,
      content => inline_epp('<%= stdlib::to_json_pretty($config) %>', {
          'config' => $config,
      }),
      owner   => $user,
      group   => $group,
    }
  }
}
