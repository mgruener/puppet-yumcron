define yumcron::config (
  $ensure = present,
  $section = 'commands',
  $value = undef,
  $configfile = '/etc/yum/yum-cron.conf',
) {

  case $ensure {
    present: {
      if $value == undef {
        fail("You have to provide a value for ${title}")
      }
      if $section == undef {
        fail("You have to provide a section for ${title}")
      }
      $action = 'set'
    }
    absent: {
      $action = 'rm'
    }
    default: { fail('Ensure can only be present or absent') }
  }

  if is_array($value) {
    $flatvalue = join($value,',')
  }
  else {
    $flatvalue = $value
  }

  augeas { "yumcron-conf-${title}":
    context => "/files${configfile}/${section}",
    incl    => $configfile,
    lens    => 'Yum.lns',
    changes => "${action} ${title} '${flatvalue}'"
  }
}
