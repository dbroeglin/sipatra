Sipatra
=======


What?
-----

Sipatra is a simple Sinatra like Ruby DSL for SIP Servlets. It's heavily inspired from Sinatra and
was adapted only in those areas that were required by differences between the HTTP and SIP
protocols. Sipatra is written is JRuby and targets SIP Servlet 1.1 compatible application servers

http://confluence.cipango.org/display/DOC/Sipatra

Quick start with the source code
--------------------------------

As a prerequisite you will need to have VirtualBox and Maven installed on your system.

    # Setup your develpment environment
    bundle install
    rake build

    # Download a Vagrant base box for Debian Squeeze 64 bit:
    vagrant box add squeeze64 http://dl.dropbox.com/u/937870/VMs/squeeze64.box

    rake test:cipango:setup
    rake test:cipango:start # will do a vagrant up
    rake test:cipango:deploy

    # Tip: Use a jruby VM when executing the specs but when doing only vagrant and deployment stuff
    # you can work with a standard MRI (1.8 or 1.9). For instance I use two gemsets: 1.9.3@vagrant 
    # and jruby-1.6.7@sipatra

Connect to the box and launch a simple sipp UAS:

    sipp -sn uas -p 5090

Connect to the box in another terminal and lauch a simple sipp UAC:

    sipp -sn uac -rsa 127.0.1.1:5060 -p 5080 127.0.0.1:5090 -m 1
