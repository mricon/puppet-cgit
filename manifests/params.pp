# == Class: cgit::params
#
# Setup parameters for cgit
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

class cgit::params {
  $manage_package      = true
  $package_name        = 'cgit'
  $package_ensure      = 'installed'
  $configfile          = '/etc/cgitrc'
  $reposdir            = '/var/lib/git'
  $cachedir            = '/var/cache/cgit'
  $cachedir_owner      = 'apache'
  $cachedir_group      = 'root'
  $cachedir_mode       = '0755'

  $use_virtual_sites   = false
  $sites_configdir     = '/etc/cgitrc.d'
  $sites_skindir       = '/var/www/html/cgit'
}
