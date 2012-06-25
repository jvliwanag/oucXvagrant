$vagrant_dir = '/vagrant'
$conf_dir = '/home/vagrant/conf'

# SELinux
file { '/etc/selinux/config': source => "$conf_dir/selinux", }
service { 'iptables': ensure => 'stopped', }

# Erlang

# yumrepo { 'erlang-solutions':
#   name => 'erlang-solutions',
#   baseurl => 'http://binaries.erlang-solutions.com/rpm/fedora/$releasever/$basearch',
#   gpgcheck => 1,
#   gpgkey => 'http://binaries.erlang-solutions.com/debian/erlang_solutions.asc',
#   enabled => 1,
# }

# package { 'esl-erlang':
#   ensure => installed,
#   require => Yumrepo['erlang-solutions'],
# }

package {'erlang':
	ensure => installed,
}

# sipXecs

yumrepo { 'sipXecs-testing':
  name => 'sipXecs-testing',
  baseurl => 'http://download.sipfoundry.org/pub/sipXecs/snapshot/Fedora_$releasever/$basearch',
  gpgcheck => 0,
}

$sipx_build_deps = ['make', 'automake', 'libtool', 'git', 'bind', 'bind-utils',
'boost', 'boost-devel', 'cfengine', 'chkconfig', 'cppunit-devel', 'dejavu-serif-fonts', 'dhcp',
'fontconfig', 'httpd', 'mod_ssl', 'mongodb', 'mongodb-server',
'net-snmp', 'net-snmp-libs', 'net-snmp-sysvinit', 'net-snmp-utils',
'ntp', 'openssl', 'openssl-devel', 'patch', 'pcre', 'pcre-devel', 'postgresql-odbc', 'postgresql-server',
'rpm', 'rpm-libs', 'ruby', 'ruby-dbi', 'rubygem-daemons', 'rubygems', 'ruby-libs', 'ruby-postgres',
'sec', 'sendmail', 'sendmail-cf', 'shadow-utils', 'sipx-openfire', 'stunnel', 'tftp', 'tftp-server', 'unixODBC',
'unixODBC-devel', 'vsftpd', 'which', 'xerces-c', 'xerces-c-devel']

package { $sipx_build_deps: ensure => "installed", require => Yumrepo['sipXecs-testing'] }

# freeswitch

package { 'freeswitch': ensure => "installed", }

# mongodb

service { 'mongod':
	ensure => 'running',
	require => [Package['mongodb-server'], File['/etc/mongod.conf']],
  start => '/usr/bin/mongod -f /etc/mongod.conf',
}

file { '/etc/mongod.conf':
  source => "$conf_dir/mongod.conf",
  require => Package['mongodb-server'],
}

# OpenACD

# Apache httpd

service { 'httpd':
  ensure => 'running',
  require => [Package['httpd'], File['/etc/httpd/conf.d/ouc-vhost.conf']],
}

file { '/etc/httpd/conf.d':
  ensure => 'directory',
  require => Package['httpd'],
}

file { '/etc/httpd/conf.d/ouc-vhost.conf':
  source => "$conf_dir/ouc-vhost.conf",
  require => File['/etc/httpd/conf.d'],
}

# oucXopenACDWeb

package { 'java-1.7.0-openjdk-devel': ensure => 'installed', }

# play

exec { 'get_play_framework':
  command => '/usr/bin/wget http://download.playframework.org/releases/play-2.0.1.zip -O /tmp/play-2.0.1.zip && /usr/bin/unzip -d /opt /tmp/play-2.0.1.zip',
  creates => '/opt/play-2.0.1',
  timeout => 0,
  require => Package['wget', 'unzip']
}

file { '/opt/play-2.0.1':
  ensure => 'directory',
  owner => 'vagrant',
  group => 'vagrant',
  recurse => 'true',
  require => Exec['get_play_framework'],
}

# Utils

package {'wget': ensure => installed, }
package {'unzip': ensure => installed, }
package {'mongo': ensure => installed, provider => 'gem', }
package {'bson_ext': ensure => installed, provider => 'gem', }

package {'ack': ensure => installed, }
package {'vim-enhanced': ensure => installed, }

# Home

file { '/home/vagrant/.bashrc':
  owner => 'vagrant',
  group => 'vagrant',
  source => '/home/vagrant/conf/.bashrc',
}

file { '/home/vagrant/workspace':
  ensure => 'directory',
  owner => 'vagrant',
  group => 'vagrant',
}