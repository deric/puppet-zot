# @summary Zot installation
# @param binary
# @param version
# @api private
class zot::install (
  String           $binary = $zot::binary,
  Stdlib::Unixpath $bin_path = $zot::bin_path,
  String           $version = $zot::version,
  Zot::Arch        $arch = $zot::arch,
  Stdlib::HTTPUrl  $download_mirror = $zot::download_mirror,
) {
  $zot_binary = "${bin_path}/${zot::binary}"
  # add suffix for specific version
  $_zot = "${zot_binary}-${version}"
  # archive won't replace binay upon version change
  archive { $_zot:
    source          => "${zot::download_mirror}/v${version}/zot-linux-${arch}",
    checksum_verify => false,
    extract         => true,
    extract_path    => $bin_path,
    extract_command => 'chmod +x %s',
    cleanup         => false,
    creates         => [$zot_binary],
  }

  file { $zot_binary:
    ensure  => link,
    target  => $_zot,
    replace => true,
  }

  if $zot::manage_zli {
    $zli_binary = "${bin_path}/zli"
    $_zli = "${zli_binary}-${version}"
    archive { $_zli:
      source          => "${zot::download_mirror}/v${version}/zli-linux-${arch}",
      checksum_verify => false,
      extract         => true,
      extract_path    => $bin_path,
      extract_command => 'chmod +x %s',
      cleanup         => false,
      creates         => [$zli_binary],
    }

    file { $zli_binary:
      ensure  => link,
      target  => $_zli,
      replace => true,
    }
  }
}
