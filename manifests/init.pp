# == Class: cgit
#
# Cgit configuration and managent module
#
# == Parameters
#
# See README.md
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
class cgit (
  Boolean               $manage_package      = $cgit::params::manage_package,
  String                $package_name        = $cgit::params::package_name,
  Enum['present','absent','installed','latest']
                        $package_ensure      = $cgit::params::package_ensure,
  Pattern['^\/']        $configfile          = $cgit::params::configfile,
  Pattern['^\/']        $reposdir            = $cgit::params::reposdir,
  Pattern['^\/']        $cachedir            = $cgit::params::cachedir,
  String                $cachedir_owner      = $cgit::params::cachedir_owner,
  String                $cachedir_group      = $cgit::params::cachedir_group,
  String                $cachedir_mode       = $cgit::params::cachedir_mode,

  Boolean               $use_virtual_sites   = $cgit::params::use_virtual_sites,
  Pattern['^\/']        $sites_configdir     = $cgit::params::sites_configdir,
  Pattern['^\/']        $sites_skindir       = $cgit::params::sites_skindir,

  Hash $sites = {},

) inherits cgit::params {

  include cgit::install
  include cgit::config
}
