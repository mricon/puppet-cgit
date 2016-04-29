class cgit::install {
  if ($cgit::manage_package) {
    ensure_packages ([
      $cgit::package_name,
    ],
    { ensure => $cgit::package_ensure }
    )
  }

  file { $cgit::cachedir:
    ensure => 'directory',
    owner  => $cgit::cachedir_owner,
    group  => $cgit::cachedir_group,
    mode   => $cgit::cachedir_mode,
  }

  if $cgit::use_virtual_sites {
    file { $cgit::sites_configdir:
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }
    file { $cgit::sites_skindir:
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }

  } else {

    if $cgit::skindir_src != $cgit::skindir {
      file { $cgit::skindir:
        ensure  => 'directory',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => $cgit::skindir_src,
        recurse => true,
      }
    }
  }
}
