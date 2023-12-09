# @summary Zot installation
# @param binary
# @param version
# @api private
class zot::install (
  String $binary = $zot::binary,
  String $version = $zot::version,
  # $facts['os']['architecture'] is on RedHat x86_64 while on Debian amd64
  String $arch = 'amd64',
) {
  $_zot = "${binary}-${version}"
  # archive won't replace binay upon version change
  archive { $_zot:
    source          => "https://github.com/project-zot/zot/releases/download/v${version}/zot-linux-${arch}",
    checksum_verify => false,
    extract         => true,
    extract_path    => '/usr/bin',
    extract_command => 'chmod +x %s',
    cleanup         => false,
    creates         => [$binary],
  }

  file { $binary:
    ensure  => link,
    target  => $_zot,
    replace => true,
  }

  archive { '/usr/bin/zli':
    source          => "https://github.com/project-zot/zot/releases/download/v${version}/zli-linux-${arch}",
    checksum_verify => false,
    extract         => true,
    extract_path    => '/usr/bin',
    extract_command => 'chmod +x %s',
    cleanup         => false,
    creates         => ['/usr/bin/zli'],
  }
}
