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

$sipx_build_deps = ['make', 'automake', 'libtool', 'git']
package { $sipx_build_deps: ensure => "installed" }

# freeswitch

package { 'freeswitch':
  ensure => installed,
  require => Yumrepo['sipXecs-testing'],
}

# mongodb

package { 'mongodb-server':
  ensure => installed,
  require => Yumrepo['sipXecs-testing'],
}

service { 'mongod':
	ensure => 'running',
	require => Package['mongodb-server'],
}

# OpenACD

# Apache httpd

package { 'httpd':
  ensure => installed,
}

service { 'httpd':
  ensure => 'running',
  require => Package['httpd'],
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

# Utils

package {'wget': ensure => installed, }
package {'unzip': ensure => installed, }

# Home

file { '/home/vagrant/.bashrc':
  owner => "vagrant",
  group => "vagrant",
  source => "/home/vagrant/conf/.bashrc",
}
