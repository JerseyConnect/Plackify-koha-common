#!/usr/bin/perl
#
# PSGI application for koha-common
#

use Plack::Builder;
use Plack::App::CGIBin;
use Plack::App::Directory;
 
use lib("/usr/share/koha/lib");
use C4::Context;
use C4::Languages;
use C4::Members;
use C4::Dates;
use C4::Boolean;
use C4::Letters;
use C4::Koha;
use C4::XSLT;
use C4::Branch;
use C4::Category;
 
my $root = ( $ENV{INTRANETDIR} ) ?
                $ENV{INTRANETDIR} . '/cgi-bin' :
                $ENV{OPACDIR} . '/cgi-bin/opac' ;
 
my $app=Plack::App::CGIBin->new(root => $root);

#
# Static file paths can be removed if Koha sits behind a forward proxy (like nginx)
#

builder {

        # Include static files
        mount "/opac-tmpl"     => Plack::App::File->new(root => "/usr/share/koha/opac/htdocs/opac-tmpl");
        mount "/intranet-tmpl" => Plack::App::File->new(root => "/usr/share/koha/intranet/htdocs/intranet-tmpl");

        # Include static files with misleading paths
        mount "/opac-tmpl/lib/yui" => Plack::App::File->new(root => "/usr/share/koha/opac/htdocs/opac-tmpl/prog/en/css");
        mount "/container"         => Plack::App::File->new(root => "/usr/share/javascript/yui/container");
        mount "/menu"              => Plack::App::File->new(root => "/usr/share/javascript/yui/menu");
        mount "/utilities"         => Plack::App::File->new(root => "/usr/share/javascript/yui/utilities");

        # include the application
        mount "/cgi-bin/koha" => $app;
 
};