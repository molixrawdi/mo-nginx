# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include nginx::servicenginx
class nginx::servicenginx {
  service { 'nginx':
    ensure => 'running',
    enable => true,
    require => Package['nginx'],
  }

}
