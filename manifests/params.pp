class yumcron::params {
  $package = 'yum-cron'

  case $::operatingsystem {
    'Fedora': { $service_name = 'yum-cron.service'
                $service_provider = systemd
    }
    default: {  $service_name = 'yum-cron'
                $service_provider = undef
    }
  }
}
