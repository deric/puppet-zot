# @summary Zot installation
# @param binary
# @param version
# @api private
class zot::install (
  String $binary = $zot::binary,
  String $version = $zot::version,
) {
  archive { $binary:
    source          => "https://github.com/project-zot/zot/releases/download/v${version}/zot-linux-amd64",
    checksum_verify => false,
    extract         => true,
    extract_path    => '/usr/bin',
    extract_command => 'chmod +x %s',
    cleanup         => false,
    creates         => [$binary],
  }

  archive { '/usr/bin/zli':
    source          => "https://github.com/project-zot/zot/releases/download/v${version}/zli-linux-amd64",
    checksum_verify => false,
    extract         => true,
    extract_path    => '/usr/bin',
    extract_command => 'chmod +x %s',
    cleanup         => false,
    creates         => ['/usr/bin/zli'],
  }
}
