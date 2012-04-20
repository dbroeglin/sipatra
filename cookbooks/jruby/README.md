Description
===========

Installs JRuby into `/usr/local/lib/jruby`

Binaries are linked to `/usr/local/bin/jruby`

Requirements
============

Platform:

* Debian, Ubuntu (tested on 10.04)

The following Opscode cookbooks are dependencies:

* java

Attributes
==========

* `['jruby']['version']`
* `['jruby']['checksum']`
* `['jruby']['install_path']`
 

Usage
=====

include_recipe "jruby"

Updating Metadata
=================

    knife cookbook metadata chef-jruby -o ../