Plackify-koha-common
====================

A set of scripts to supercharge your `koha-common` install with Plack

Setup
-----

1.   Ensure Plack dependencies are satisfied (see Requirements, below).
1.   Run `install.sh` from your clone or download directory to install scripts.
1.   Use `koha-start-plack [instance name]` and `koha-stop-plack [instance name]` to control your Plack servers.

Optionally let the installer update your `koha-common` init script to make Plack a first-class part of your Koha environment.

Requirements
------------

You'll need to install a few packages in order to run Plack servers.

`apt` packages:

*   make
*   build-essential
*   starman

**Note::** Starman can also be installed from CPAN

`CPAN` packages:

*   CGI::Emulate::PSGI
*   CGI::Compile

Use these simple commands to take care of dependencies:

    sudo apt-get install make build-essential starman
    cpan -i CGI::Emulate::PSGI CGI::Compile
