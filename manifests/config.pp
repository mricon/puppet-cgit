# == Class: cgit::config
#
# Global config settings for cgitrc
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
class cgit::config (
  Enum['present','absent']      $ensure      = 'present',
  Pattern['^\/']                $configfile  = $cgit::configfile,
  String                        $skindir     = '/usr/share/cgit',
  String                        $skindir_src = '/usr/share/cgit',
  Pattern['^\/']                $cache_root  = $cgit::cachedir,

  Array                         $clone_prefix = [
    'http://\$HTTP_HOST'
  ],

  Pattern['^\/.*\.css$']        $css        = '/cgit-data/cgit.css',
  Pattern['^\/']                $logo       = '/cgit-data/cgit.png',
  String                        $root_desc  = 'A fast web interface to git',
  String                        $root_title = 'Git Repository Browser',
  Optional[Pattern['^\/']]      $favicon    = undef,

  Integer[0]                    $cache_size = 1000,

  Pattern['^\/']                $scan_path    = $cgit::reposdir,

  Optional[Pattern['^\/']]      $project_list = undef,
  Optional[Pattern['^\/']]      $virtual_root = undef,

  Optional[String]              $agefile = undef,

  Optional[Integer[-1]]         $cache_static_ttl   = -1,
  Optional[Integer[-1]]         $cache_dynamic_ttl  = 5,
  Optional[Integer[-1]]         $cache_repo_ttl     = 5,
  Optional[Integer[-1]]         $cache_root_ttl     = 5,
  Optional[Integer[-1]]         $cache_scanrc_ttl   = 15,
  Optional[Integer[-1]]         $cache_about_ttl    = 15,
  Optional[Integer[-1]]         $cache_snapshot_ttl = 5,

  Optional[Enum['age','name']]  $branch_sort         = undef,
  Optional[Boolean]             $case_sensitive_sort = undef,
  Optional[Enum['date','topo']] $commit_sort         = undef,
  Optional[Enum['age','name']]  $repository_sort     = undef,
  Optional[Boolean]             $section_sort        = undef,

  Optional[Array]               $clone_url     = undef,

  Optional[String]              $about_filter  = undef,
  Optional[String]              $auth_filter   = undef,
  Optional[String]              $commit_filter = undef,
  Optional[String]              $email_filer   = undef,
  Optional[String]              $owner_filter  = undef,
  Optional[String]              $source_filter = undef,

  Optional[Boolean]             $enable_commit_graph     = undef,
  Optional[Boolean]             $enable_filter_overrides = undef,
  Optional[Boolean]             $enable_follow_links     = undef,
  Optional[Boolean]             $enable_http_clone       = undef,
  Optional[Boolean]             $enable_index_links      = undef,
  Optional[Boolean]             $enable_index_owner      = undef,
  Optional[Boolean]             $enable_log_filecount    = undef,
  Optional[Boolean]             $enable_log_linecount    = undef,
  Optional[Boolean]             $enable_remote_branches  = undef,
  Optional[Boolean]             $enable_subject_links    = undef,
  Optional[Boolean]             $enable_html_serving     = undef,
  Optional[Boolean]             $enable_tree_linenumbers = undef,
  Optional[Boolean]             $enable_git_config       = undef,

  Optional[Pattern['^\/']]      $footer       = undef,
  Optional[Pattern['^\/']]      $head_include = undef,
  Optional[Pattern['^\/']]      $header       = undef,
  Optional[Pattern['^\/']]      $include      = undef,
  Optional[Pattern['^\/']]      $root_readme  = undef,

  Optional[Boolean]             $embedded           = undef,
  Optional[Boolean]             $noheader           = undef,
  Optional[String]              $module_link        = undef,
  Optional[String]              $logo_link          = undef,
  Optional[Boolean]             $remove_suffix      = undef,
  Optional[Boolean]             $noplainemail       = undef,
  Optional[String]              $robots             = undef,
  Optional[Integer[0]]          $section_from_path  = undef,
  Optional[Boolean]             $side_by_side_diffs = undef,
  Optional[Array]               $snapshots          = undef,
  Optional[Boolean]             $local_time         = undef,

  Array                         $default_readme     = [
    ':README.md',
    ':README.rst',
    ':README.html',
    ':README.txt',
    ':README',
    ':readme.md',
    ':readme.rst',
    ':readme.html',
    ':readme.txt',
    ':readme',
  ],

  Optional[Array]               $readme             = undef,

  Optional[Integer[1]]          $max_atom_items      = undef,
  Optional[Integer[1]]          $max_commit_count    = undef,
  Optional[Integer[20]]         $max_message_length  = undef,
  Optional[Integer[1]]          $max_repo_count      = undef,
  Optional[Integer[20]]         $max_repodesc_length = undef,
  Optional[Integer[0]]          $max_blob_size       = undef,
  Optional[Enum['week','month','quarter','year']]
                                $max_stats           = undef,
  Optional[Integer[-1]]         $renamelimit         = undef,
  Optional[Integer[1]]          $summary_branches    = undef,
  Optional[Integer[1]]          $summary_log         = undef,
  Optional[Integer[1]]          $summary_tags        = undef,

  Hash                          $default_mimetypes   = {
    'txt'  => 'text/plain',
    'html' => 'text/html',
    'gif'  => 'image/gif',
    'jpg'  => 'image/jpeg',
    'png'  => 'image/png',
    'svg'  => 'image/svg+xml',
    'pdf'  => 'application/pdf',
  },

  Optional[Hash]                $mimetypes           = undef,
  Optional[Pattern['^\/']]      $mimetype_file       = undef,

  Optional[Boolean]             $scan_hidden_path    = undef,

) inherits cgit {

  if $readme {
    $merged_readme  = $default_readme + $readme
  } else {
    $merged_readme = $default_readme
  }
  if $mimetypes {
    $merged_mimetypes = merge($default_mimetypes, $mimetypes)
  } else {
    $merged_mimetypes = $default_mimetypes
  }

  if $cgit::use_virtual_sites {
    file { $cgit::configfile:
      ensure   => 'present',
      owner    => 'root',
      group    => 'root',
      mode     => '0644',
      content  => "# MANAGED BY PUPPET\ninclude=${cgit::sites_configdir}/\$HTTP_HOST\n",
      checksum => 'md5',
    }
    create_resources('cgit::resource::site', $cgit::sites)
  } else {
    file { $cgit::configfile:
      ensure   => 'present',
      owner    => 'root',
      group    => 'root',
      mode     => '0644',
      content  => template('cgit/cgitrc.erb'),
      checksum => 'md5',
    }
  }

}

