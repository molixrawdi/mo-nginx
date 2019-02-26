# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include nginx::setupnginxrepo
class nginx::setupnginxrepo {
  exec{ 'install repo gpg key':
    command => 'rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7',
    path => ['/bin','/sbin','/usr/bin'],
    provider => 'shell',
  }


  file{'/etc/yum.repos.d/nginx.repo':
    ensure => 'file',
    source => 'puppet:///modules/nginx/nginx.repo',
  }

}
