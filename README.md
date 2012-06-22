oucXvagrant
-----------

This project includes a VM definition using Vagrant to easily start off on a working OpenACD/OpenUC set-up. The VM used is based on a Fedora 16 i386 image.

* OpenACD
* sipXopenacd plug-in
* oucXopenacdWeb


Set-up
------

1. Install [Virtualbox](http://virtualbox.org/).
2. Install Ruby for your system.
3. Install Vagrant.
> sudo gem install vagrant
4. Install the FC 16 box.
> vagrant box add fedora-16 http://TODO/
5. Check-out the project:
> git clone git@github.com:jvliwanag/oucXvagrant.git oucx
6. Set-up the git submodules.
> cd oucx
> git submodule init && git submodule update
7. Start vagrant
> vagrant up # can take several minutes to start and set-up
8. Dive into ssh
> vagrant ssh

Shortcuts
---------
oa - Starts OpenACD
oareset - Resets MongoDB with known data
oup - Runs oucXvagrant play


Gotchas
-------

1. Vagrant 1.0.3 fails in creating a host-only network for the Fedora Core 16. 

        The following SSH command responded with a non-zero exit status.

        Vagrant assumes that this means the command failed!

        /sbin/ifup p7p1 2> /dev/null"

See [here](https://github.com/monvillalon/vagrant/commit/dc9830350a0f2be3bb7a4b4e9fcefaed66c6a26a) for workaround.