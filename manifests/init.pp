class yumcron (
  $package = $::yumcron::params::package,
  $config = undef,
  $hiera_merge = false,
) inherits ::yumcron::params {
  $myclass = $module_name

  case type($hiera_merge) {
    'string': {
      validate_re($hiera_merge, '^(true|false)$', "${myclass}::hiera_merge may be either 'true' or 'false' and is set to <${hiera_merge}>.")
      $hiera_merge_real = str2bool($hiera_merge)
    }
    'boolean': {
      $hiera_merge_real = $hiera_merge
    }
    default: {
      fail("${myclass}::hiera_merge type must be true or false.")
    }
  }

  if $config != undef {
    if !is_hash($config) {
        fail("${myclass}::config must be a hash.")
    }

    if $hiera_merge_real == true {
      $config_real = hiera_hash("${myclass}::config",undef)
    } else {
      $config_real = $config
    }

    create_resources('yumcron::config',$config_real)
  }

  package { $package:
    ensure => present
  }
}
