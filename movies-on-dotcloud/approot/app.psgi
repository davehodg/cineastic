#!/use/bin/perl

use strict;
use warnings;

use CGI::Application::PSGI;
use lib qw /lib/;
use CGI::Application::Plugin::ConfigAuto (qw/cfg/);

require Movies;


use       CGI::Application::PSGI;
use       CGI::Application;
use       CGI::PSGI;
use       CGI;
use       Cache::File;
use       Crypt::SSLeay;
use       DBD::mysql;
use       DBIx::Class::Schema::Loader;
use       DBIx::Class;
use       Dancer;
use       Digest::SHA1;
use       Encode;
use       HTML::Entities::Numbered;
use       HTML::Template;
use       HTML::TreeBuilder;
use       IO::CaptureOutput;
use       IO::Scalar;
#use       JSON;
use       List::Util ;
use       Module::Build;
use       Module::Metadata;
use       Parallel::ForkManager;
use       Perl::OSType;
use       PerlIO::gzip;
use       Plack;
use       SQL::Translator;
use       Tie::IxHash;
use       Time::HiRes;
use       URI::Escape;
use       URI;
use       Unicode::Map8;
use       Unicode::String;
use       WWW::Facebook::API;
use       XML::Filter::BufferText;
use       XML::Handler::YAWriter;
use       XML::SAX::Writer;
use       XML::Simple;
use       XML::Twig  ;
use       XML::Twig;
use       XML::XPath ;
use       XML::XPathEngine;
use       local::lib;


my $app = sub {
    my $env = shift;
    my $app = Movies->new
	({ 
	    QUERY => CGI::PSGI->new($env),
	    PARAMS => { cfg_file => 'config.yml' }
	 });

    CGI::Application::PSGI->run($app);
};
