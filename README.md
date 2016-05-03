# cgit

#### Table of Contents

1. [Overview](#overview)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)

## Description

[![Build Status](https://travis-ci.org/mricon/puppet-cgit.png)](https://travis-ci.org/mricon/puppet-cgit)

This module configures cgit. At this time, it leaves out
nginx/apache/whathaveyou configuration up to some other module, and will add
this step as optional in the future. There are just too many ways to serve
cgit (basic apache cgit, fastcgi, spawn-fcgi with nginx, lighttpd, etc), so
this module concentrates on setting up just the basic config to the point
where you can then configure the serving part on your own.

## Usage

To use this module you can either directly include it in your module
tree, or add the following to your `Puppetfile`:

```
  mod 'mricon-cgit'
```

A node should then be assigned the relevant cgit classes.

There are two basic ways to use the module -- with or without virtual hosting.
When used in a default configuration without virtual hosting, the module
tracks and configures `/etc/cgitrc`. The most basic configuration with sane
defaults is:

```puppet
   class { 'cgit':
     reposdir => '/path/to/your/repos'
   }
```

This will configure the cache location to be owned by user `apache`, so if you
are running with some other webserver, make sure you tweak `cachedir_owner`,
e.g. for nginx:

```puppet
   class { 'cgit':
     reposdir       => '/path/to/your/repos',
     cachedir_owner => 'nginx',
   }
```

If you're using Hiera, the same configuration might look like:

```yaml
   cgit::reposdir: '/path/to/your/repos'
   cgit::cachedir_owner: 'nginx'
```

### Virtual sites

If you are hosting multiple repo collections on the same server, this module
supports basic virtual hosting. For example, if you have
`/var/lib/git/git.kernel.org` and `/var/lib/git/git.opnfv.org` directories
full of project-specific repos, you will want to configure things as follows:

```puppet
   class { 'cgit':
     reposdir           => '/var/lib/git',
     use_virtual_sites  => true,
     config             => {
       virtual_root      => '/',
       enable_git_config => true,
     }
     sites              => {
       'git.kernel.org' => {
         ensure            => 'present',
         skindir_src       => 'puppet:///modules/cgit/git.kernel.org',
         section_from_path => 1,
       }
       'git.opnfv.org'  => {
         ensure         => 'present',
         skindir_src    => 'puppet:///modules/cgit/git.opnfv.org',
       }
     }
   }
```

This will create `/etc/cgitrc` with the following content:

```
include=/etc/cgitrc.d/$HTTP_HOST
```

Then each defined site will have an entry in `/etc/cgitrc.d`:

* `/etc/cgitrc.d/git.kernel.org`
* `/etc/cgitrc.d/git.opnfv.org`

The same configuration in hiera would look like this:

```yaml
   cgit::reposdir: '/var/lib/git'
   cgit::use_virtual_sites: true
   cgit::config::virtual_root: '/'
   cgit::config::enable_git_config: true
   cgit::sites:
     'git.kernel.org':
       ensure: 'present'
       skindir_src: 'puppet:///modules/cgit/git.kernel.org'
       section_from_path: 1
     'git.opnfv.org':
       ensure: 'present'
       skindir_src: 'puppet:///modules/cgit/git.opnfv.org'
```

Anything you define as part of global cgit=>config will be inherited by each
defined site, but you can override any part of it by defining a separate
site-specific config value.

## Reference

### cgit

#### `manage_package`

Whether to manage the package installation or not.

Default: `true`

#### `package_name`

The name of the package to install.

Default: `cgit`

#### `package_ensure`

Whether to install or remove the package (e.g. if you're installing cgit via
some other way).

Default: `present`

#### `configfile`

Global cgit config file.

Default: `/etc/cgitrc`

#### `reposdir`

Where your repositories live.

Default: `/var/lib/git`

#### `cachedir`

Where to put cgit cache.

Default: `/var/cache/cgit`

#### `cachedir_owner`, `cachedir_group`, `cachedir_mode`

Who should own the cache directory, and what its mode should be

Defaults: `apache`, `root`, `0755`

#### `use_virtual_sites`

Whether to use a global configuration or set up virtual sites.

Default: `false`

#### `sites_configdir`

Where to put site-specific configuration files.

Default: `/etc/cgitrc.d`

#### `sites_skindir`

Where to put site-specific skin files (css, logo, favicon, etc). You would
usually then specify a site-specific `skindir_src` that would point at a
location in puppet from where to recursively copy these objects. You will need
to configure your httpd virtual host so that `$skindir_src/git.example.com` is
aliased to `/cgit-data` for that site.

When `skindir_src` is not specified, the module will copy the default
`/usr/share/cgit` skin in place.

Default: `/var/www/html/cgit`

### config

Values here are one-to-one mapping to cgit configuration parameters, with all
dashes changed to underscores. E.g. a cgit configuration parameter
`section-from-path` will become `section_from_path`.

There are too many configuration parameters here to bother listing them all,
so your best bet is looking at the config.pp file.

All configuration in the config class is inherited by each defined virtual
site, if you're using them. You can override each global configuration entry
by setting a separate site-specific config value.

## Limitations

Tested on RHEL 6/7 and CentOS 6/7. Not tested anywhere else. :)
