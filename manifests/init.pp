class yumcron (
  $package = $::yumcron::params::package
) inherits ::yumcron::params {

  package { $package:
    ensure => present
  }
}
