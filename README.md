Welcome to the 'NGINX' module. This was generated through PDK tool, the PDK documentation at https://puppet.com/pdk/latest/pdk_generating_modules.html .

The README template below provides a starting point with details about what information to include in your README.

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with nginx](#setup)
    * [What nginx affects](#what-nginx-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nginx](#beginning-with-nginx)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Ideas and requests](#ideas)
6. [Diagnostics Module,to help](#Diagnostics)
7. [Interpolation complexity and effects](#Interpolation complexity)
## Description

This module's purpose was to install the 'NGINX' webserver with a standard configuration. This module can provide an automated way of installing 'NGINX' to a basic configuration.



## Setup
 vagrant needs to bne adjusted (if that is being used)

```
Vagrant.configure(2) do |config|
  config.vm.box = "hashicorp/<disto-choice)"
  config.vm.provision "shell", path: "provision.sh"
  config.vm.network "forwarded_port", guest: 80, host: 8080, id: "nginx"
end

```
### What nginx affect


This is designed to install 'NGINX" on a Centos,Redhat,Or Scientific Linux version 7, supporting 64-bit architecture Intel/AMD. This is tested on Centos7. 

## Setup

### What nginx affect


This is designed to install 'NGINX" on a Centos,Redhat,Or Scientific Linux version 7, supporting 64-bit architecture Intel/AMD. This is tested on Centos7.

* Files, packages, services, to be added:
```
### nginx-all-modules                        noarch              1:1.12.2-2.el7                 @epel              0.0
### nginx-mod-http-geoip                     x86_64              1:1.12.2-2.el7                 @epel               21 k
### nginx-mod-http-image-filter              x86_64              1:1.12.2-2.el7                 @epel               24 k
### nginx-mod-http-perl                      x86_64              1:1.12.2-2.el7                 @epel               54 k
### nginx-mod-http-xslt-filter               x86_64              1:1.12.2-2.el7                 @epel               24 k
### nginx-mod-mail                           x86_64              1:1.12.2-2.el7                 @epel               99 k
### nginx-mod-stream                         x86_64              1:1.12.2-2.el7                 @epel              157 k

```
Dependencies that module automatically install are any modules related to the above in the list. Managed via yum.


### Setup Requirements/options

#### Separate Management components from code, below the 3 modules (profile,role,node), used for management purpose:
```
/etc/puppetlabs/code/modules/[profile,role,node]  
```

### Live code reside within 

```
/etc/puppetlabs/code/environments/<target-environment>/modules/[target-module:(nginx)]
```

### Way to activate a puppet apply:

```

[node]---->[Role(s)]------>[Profile(s)]---------->[Target-class(could be more than one if needed)]

```

This module comes with 3 more modules that are designed to run in conjuncition with it . They are 'role', 'profile' and 'node'.
'profile' will call the main class in this module, this is contained within the file 'init.pp' the main class is 'nginx'. placed at '/etc/puppetlabs/code/modules', to achieve seperation of Management from configuration.
'role' will call the profile, can have many more profiles attached to build more complex role if needed. Placed at '/etc/puppetlabs/code/modules,
'node' will call the role, can have more roles attached to it. This will depend on the requirement, placed at '/etc/puppetlabs/code/modules/.
'nginx' module should be installed at 'etc'puppetlabs/code/environments/<specific-envirnment>/modules. 

### Beginning with nginx
 A basic setup of nginx, has the stop start and status basic functions to run from command line. comes with the basic out of the box nginx setup.
## Usage

```
### `systemctl status nginx.service`

#### 'systemctl start nginx.service'

##### `systemctl stop nginx.service`

```

## Limitations

Designed for Redhat 7 based systems on a 64 bit archiecture.
Firewall settings and network features are not included in this module configuration, this is assumed to be working prior to this module activation.

Can run puppet apply on the role class connected to the profile(s) class, which in tern connects to the target (nginx) class, can't run the target class through apply directly, unless its deconstucted to its basic resources (exec,file,service, package).

 
## Ideas
The team wanted to ensure that the operation of the 'exec' resource will not re-occur with out purpose, hence an 'onlyif' statement was added to make the code more efficient:
```

class nginx::setupnginxrepo {
  exec{ 'install repo gpg key':
    command => 'rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7',
    path => ['/bin','/sbin','/usr/bin'],
    provider => 'shell',
    onlyif => ['test ! -f /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7'],
  }

```

#####Diagnostics module:

This is aimed at helping with the operational side of the webserver once its installed, came accross some issues once trying to make it work within 'vagrant' thought it would be usefull to have tools that would help debug the connectivity issues that are likely to be encountered by the webserver-server.

###Hiera: This is a database with 'key:value: setup. MOst effective wway to test that the mapping works and that the values added are detectible by hiera is to test using the follwoing syntax:

```
puppet lookup diagnostics::netools --explain

```
Output of the test above is


```
[root@localhost data]# puppet lookup diagnostics::netools --explain
Searching for "lookup_options"
  Global Data Provider (hiera configuration version 5)
    Using configuration "/etc/puppetlabs/puppet/hiera.yaml"
    No such key: "lookup_options"
  Environment Data Provider (hiera configuration version 5)
    Using configuration "/etc/puppetlabs/code/environments/production/hiera.yaml"
    Hierarchy entry "Other YAML hierarchy levels"
      Merge strategy hash
        Path "/etc/puppetlabs/code/environments/production/data/common.yaml"
          Original path: "common.yaml"
          No such key: "lookup_options"
        Path "/etc/puppetlabs/code/environments/production/data/diagnostics.yaml"
          Original path: "diagnostics.yaml"
          No such key: "lookup_options"
        Path "/etc/puppetlabs/code/environments/production/data/localhost.yaml"
          Original path: "localhost.yaml"
          No such key: "lookup_options"
  Module "diagnostics" Data Provider (hiera configuration version 5)
    Using configuration "/etc/puppetlabs/code/environments/production/modules/diagnostics/hiera.yaml"
    Hierarchy entry "common"
      Path "/etc/puppetlabs/code/environments/production/modules/diagnostics/data/common.yaml"
        Original path: "common.yaml"
        No such key: "lookup_options"
Searching for "diagnostics::netools"
  Global Data Provider (hiera configuration version 5)
    Using configuration "/etc/puppetlabs/puppet/hiera.yaml"
    No such key: "diagnostics::netools"
  Environment Data Provider (hiera configuration version 5)
    Using configuration "/etc/puppetlabs/code/environments/production/hiera.yaml"
    Hierarchy entry "Other YAML hierarchy levels"
      Path "/etc/puppetlabs/code/environments/production/data/common.yaml"
        Original path: "common.yaml"
        No such key: "diagnostics::netools"
      Path "/etc/puppetlabs/code/environments/production/data/diagnostics.yaml"
        Original path: "diagnostics.yaml"
        No such key: "diagnostics::netools"
      Path "/etc/puppetlabs/code/environments/production/data/localhost.yaml"
        Original path: "localhost.yaml"
        No such key: "diagnostics::netools"
  Module "diagnostics" Data Provider (hiera configuration version 5)
    Using configuration "/etc/puppetlabs/code/environments/production/modules/diagnostics/hiera.yaml"
    Hierarchy entry "common"
      Path "/etc/puppetlabs/code/environments/production/modules/diagnostics/data/common.yaml"
        Original path: "common.yaml"
        Found key: "diagnostics::netools" value: "net-tools"

```

That output above of 'hiera/puppet' going through the structure, here it is apparent the way it will search, some contents(files)/(folders) don't exist but can be created if they help the cause of this code. This example, utilized the '[module/[diagnostics]/data/common.yaml'. The file looks like this:
``` 
---
diagnostics::netools : 'net-tools'
diagnostics::nmap : 'nmap'

``` 
The idea is that any variables can be created in such files and interpolated into the classes that are used, makes thi
s code more portable and easy to maintain, do the same for urls.


### Interpolation Complexity:

Below is an example of a rather complex interpolation way, this was due to standard one "%{variable}" failing, this is likely to be due to the issues with 'yum' and 'exec' together and the way they pass things.
Notice the entire command was wrapped in double quotes.

```
class diagnostics::netools {

 exec { 'Install Netools & NMAP':
   command => "yum -y install ${lookup('diagnostics::netoolsone')}" ,
   path => ['/bin','/sbin','/usr/bin'],
   provider => 'shell',
 }

}


```

Adding additional variable for the 'netstat package':
```
#   include diagnostics::netools
class diagnostics::netools {

 exec { 'Install Netools & NMAP':
   command => "yum -y install ${lookup('diagnostics::netoolsone')} ${lookup('diagnostics::netoolstwo')}" ,
   path => ['/bin','/sbin','/usr/bin'],
   provider => 'shell',
 }

}
```

