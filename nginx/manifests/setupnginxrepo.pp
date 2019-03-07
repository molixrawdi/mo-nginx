# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include nginx::setupnginxrepo
class nginx::setupnginxrepo {
  exec{ 'install repo gpg key':
    #command => 'rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7',
    command => "rpm --import %{epel_repo_key_url}",
    path => ['/bin','/sbin','/usr/bin'],
    provider => 'shell',
    onlyif => ['test ! -f /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7'],
  }


  file{'/etc/yum.repos.d/nginx.repo':
    ensure => 'file',
    source => 'puppet:///modules/nginx/nginx.repo',
  }

}
