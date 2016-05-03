# == Class: cgit::install
#
# Install for cgit
#
# == Parameters
#
# === Authors
#
# Konstantin Ryabitsev <konstantin@linuxfoundation.org>
#
# === Copyright
#
# Copyright 2016 Konstantin Ryabitsev
#
# === License
#
# @License Apache-2.0 <http://spdx.org/licenses/Apache-2.0>
#
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
  }
}
