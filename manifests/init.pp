# Class: cgit
# ===========================
#
# Full description of class cgit here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'cgit':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
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
