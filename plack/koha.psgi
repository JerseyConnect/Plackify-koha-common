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
 
builder {
 
        mount "/opac-tmpl"     => Plack::App::File->new(root => "/usr/share/koha/opac/htdocs/opac-tmpl");
        mount "/intranet-tmpl" => Plack::App::File->new(root => "/usr/share/koha/intranet/htdocs/intranet-tmpl");
         
        mount "/cgi-bin/koha" => $app;
 
};