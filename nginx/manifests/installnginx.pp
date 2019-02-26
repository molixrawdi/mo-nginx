# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include nginx::installnginx
class nginx::installnginx {
  package {'nginx':
  ensure => 'installed',
  }
}
