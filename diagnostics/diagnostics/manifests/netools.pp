# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include diagnostics::netools
class diagnostics::netools {

 exec { 'Install Netools & NMAP': 
   command => "yum -y install ${lookup('diagnostics::netoolsone')} ${lookup('diagnostics::netoolstwo')}" ,
   path => ['/bin','/sbin','/usr/bin'],
   provider => 'shell', 
 }

}
