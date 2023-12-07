# == Class: cgit::resource::site
#
# Per-site config settings for cgitrc
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
define cgit::resource::site (
  Enum['present','absent']      $ensure      = 'present',
  Pattern['^\/']                $configfile  = "${cgit::sites_configdir}/${name}",
  String                        $skindir     = "${cgit::sites_skindir}/${name}",
  String                        $skindir_src = '/usr/share/cgit',
  Pattern['^\/']                $cache_root  = "${cgit::cachedir}/${name}",

  Array                         $clone_prefix = [
    "http://${name}",
  ],

  Pattern['^\/.*\.css$']        $css        = $cgit::config::css,
  Optional[Pattern['^\/.*\.js$']] $js       = $cgit::config::js,
  Pattern['^\/']                $logo       = $cgit::config::logo,
  String                        $root_desc  = $cgit::config::root_desc,
  String                        $root_title = $cgit::config::root_title,
  Optional[Pattern['^\/']]      $favicon    = $cgit::config::favicon,

  Integer[0]                    $cache_size = $cgit::config::cache_size,

  Pattern['^\/']                $scan_path = "${cgit::reposdir}/${name}",

  Optional[Pattern['^\/']]      $project_list = $cgit::config::project_list,
  Optional[Pattern['^\/']]      $virtual_root = $cgit::config::virtual_root,

  Optional[String]              $agefile = $cgit::config::agefile,

  Optional[Integer[-1]]         $cache_static_ttl   = $cgit::config::cache_static_ttl,
  Optional[Integer[-1]]         $cache_dynamic_ttl  = $cgit::config::cache_dynamic_ttl,
  Optional[Integer[-1]]         $cache_repo_ttl     = $cgit::config::cache_repo_ttl,
  Optional[Integer[-1]]         $cache_root_ttl     = $cgit::config::cache_root_ttl,
  Optional[Integer[-1]]         $cache_scanrc_ttl   = $cgit::config::cache_scanrc_ttl,
  Optional[Integer[-1]]         $cache_about_ttl    = $cgit::config::cache_about_ttl,
  Optional[Integer[-1]]         $cache_snapshot_ttl = $cgit::config::cache_snapshot_ttl,

  Optional[Enum['age','name']]  $branch_sort         = $cgit::config::branch_sort,
  Optional[Enum['date','topo']] $commit_sort         = $cgit::config::commit_sort,
  Optional[Enum['age','name']]  $repository_sort     = $cgit::config::repository_sort,
  Optional[Boolean]             $section_sort        = $cgit::config::section_sort,
  Optional[Boolean]             $case_sensitive_sort = $cgit::config::case_sensitive_sort,

  Optional[Array]               $clone_url     = $cgit::config::clone_url,

  Optional[String]              $about_filter  = $cgit::config::about_filter,
  Optional[String]              $auth_filter   = $cgit::config::auth_filter,
  Optional[String]              $commit_filter = $cgit::config::commit_filter,
  Optional[String]              $email_filter  = $cgit::config::email_filter,
  Optional[String]              $owner_filter  = $cgit::config::owner_filter,
  Optional[String]              $source_filter = $cgit::config::source_filter,

  Optional[Boolean]             $enable_commit_graph     = $cgit::config::enable_commit_graph,
  Optional[Boolean]             $enable_filter_overrides = $cgit::config::enable_filter_overrides,
  Optional[Boolean]             $enable_follow_links     = $cgit::config::enable_follow_links,
  Optional[Boolean]             $enable_http_clone       = $cgit::config::enable_http_clone,
  Optional[Boolean]             $enable_index_links      = $cgit::config::enable_index_links,
  Optional[Boolean]             $enable_index_owner      = $cgit::config::enable_index_owner,
  Optional[Boolean]             $enable_log_filecount    = $cgit::config::enable_log_filecount,
  Optional[Boolean]             $enable_log_linecount    = $cgit::config::enable_log_linecount,
  Optional[Boolean]             $enable_remote_branches  = $cgit::config::enable_remote_branches,
  Optional[Boolean]             $enable_subject_links    = $cgit::config::enable_subject_links,
  Optional[Boolean]             $enable_html_serving     = $cgit::config::enable_html_serving,
  Optional[Boolean]             $enable_tree_linenumbers = $cgit::config::enable_tree_linenumbers,
  Optional[Boolean]             $enable_git_config       = $cgit::config::enable_git_config,

  Optional[Pattern['^\/']]      $header       = $cgit::config::header,
  Optional[Pattern['^\/']]      $footer       = $cgit::config::footer,
  Optional[Pattern['^\/']]      $include      = $cgit::config::include,
  Optional[Pattern['^\/']]      $head_include = $cgit::config::head_include,
  Optional[Pattern['^\/']]      $root_readme  = $cgit::config::root_readme,

  Optional[Boolean]             $embedded           = $cgit::config::embedded,
  Optional[Boolean]             $noheader           = $cgit::config::noheader,
  Optional[String]              $module_link        = $cgit::config::module_link,
  Optional[String]              $logo_link          = $cgit::config::logo_link,
  Optional[Boolean]             $remove_suffix      = $cgit::config::remove_suffix,
  Optional[Boolean]             $noplainemail       = $cgit::config::noplainemail,
  Optional[String]              $robots             = $cgit::config::robots,
  Optional[Integer[0]]          $section_from_path  = $cgit::config::section_from_path,
  Optional[Boolean]             $side_by_side_diffs = $cgit::config::side_by_side_diffs,
  Optional[Array]               $snapshots          = $cgit::config::snapshots,

  Optional[Array]               $default_readme     = $cgit::config::default_readme,
  Optional[Array]               $readme             = $cgit::config::readme,

  Optional[Boolean]             $local_time         = $cgit::config::local_time,

  Optional[Integer[1]]          $max_atom_items      = $cgit::config::max_atom_items,
  Optional[Integer[1]]          $max_commit_count    = $cgit::config::max_commit_count,
  Optional[Integer[20]]         $max_message_length  = $cgit::config::max_message_length,
  Optional[Integer[1]]          $max_repo_count      = $cgit::config::max_repo_count,
  Optional[Integer[20]]         $max_repodesc_length = $cgit::config::max_repodesc_length,
  Optional[Integer[0]]          $max_blob_size       = $cgit::config::max_blob_size,
  Optional[Enum['week','month','quarter','year']]
                                $max_stats           = $cgit::config::max_stats,
  Optional[Integer[-1]]         $renamelimit         = $cgit::config::renamelimit,
  Optional[Integer[1]]          $summary_branches    = $cgit::config::summary_branches,
  Optional[Integer[1]]          $summary_log         = $cgit::config::summary_log,
  Optional[Integer[1]]          $summary_tags        = $cgit::config::summary_tags,

  Optional[Hash]                $default_mimetypes   = $cgit::config::default_mimetypes,
  Optional[Hash]                $mimetypes           = $cgit::config::mimetypes,
  Optional[Pattern['^\/']]      $mimetype_file       = $cgit::config::mimetype_file,

  Optional[Boolean]             $scan_hidden_path    = $cgit::config::scan_hidden_path,

) {
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

  file { $configfile:
    ensure   => $ensure,
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
    content  => template('cgit/cgitrc.erb'),
    checksum => 'md5',
    require  => File[$cgit::sites_configdir],
  }

  if $ensure == 'present' {
    file { $cache_root:
      ensure  => 'directory',
      owner   => $cgit::cachedir_owner,
      group   => $cgit::cachedir_group,
      mode    => $cgit::cachedir_mode,
      require => File[$cgit::cachedir],
    }
    file { $skindir:
      ensure  => 'directory',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => $skindir_src,
      require => File[$cgit::sites_skindir],
      recurse => true,
    }
  }

}
