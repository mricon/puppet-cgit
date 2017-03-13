# 0.1.3

- Move scan-path to be the last option in cgirc, as despite what the manpages
  say, a lot of options are ignored if they happen after scan-path (such as
  branch-sort, for example, and who knows what others).

# 0.1.2

- Fix a few typos
- Move filter definitions before scan-path in the template, otherwise they do
  not necessarily get called (not documented in cgit)
