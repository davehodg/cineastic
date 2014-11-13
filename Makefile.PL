use inc::Module::Install;



name           'Movies';
version        '0.1';
license        'artistic';


#all_from       'lib/Your/Module.pm';



requires       'Module::Build' => '0.4003';
requires       'Module::Metadata' => '1.000011';
requires       'Perl::OSType';
#requires       'HTML::Template';
requires       'Templatecpanm .';
requires       'PerlIO::gzip';
requires       'local::lib';

#requires       'CGI' => '3.60';
#requires       'CGI::Application::PSGI';

requires       'Cache::File';
requires       'Time::HiRes';
requires       'Parallel::ForkManager';
requires       'Memoize';

# Specific dependencies
requires       'List::Util'  => '1.25';


requires       'HTML::TreeBuilder';
requires       'HTML::Entities::Numbered';

# requires tidyp, can't find a deb for it
#requires       'HTML::Tidy';
requires        'Unicode::Map8';
requires        'Unicode::String';
requires       'Tie::IxHash';
requires       'XML::Simple';
requires       'XML::Parser';
requires       'XML::Handler::YAWriter';
requires       'XML::SAX::Writer';
requires       'XML::Filter::BufferText';
requires       'XML::Twig' => '3.41';
requires	'Plack::Handler::Twiggy';
requires       'IO::Scalar';
requires       'IO::CaptureOutput';
requires       'XML::XPathEngine';
requires       'YAML::XS';

requires       'Encode' => '2.44';

# need  mysql-client mysql-server  libmysqlclient-dev
requires       'SQL::Translator' => '0.11012';
requires       'DBIx::Class' => '0.08199';
requires       'DBIx::Class::Schema::Loader';

requires       'URI';
requires       'URI::Escape';
requires       'DBD::mysql' => '4.021';
requires       'CGI::Application' => '4.50' ;
requires	'CGI::Application::Plugin::ConfigAuto';
requires       'Dancer' => '1.3099';
requires       'Plack' => '1.0002' ;
requires       'CGI::PSGI';
requires       'JSON';
requires	'DateTime::Format::MySQL';
requires       'Digest::SHA1';

# needs libexpat-dev for XML::Parser

# needs ssl-dev
requires       'Crypt::SSLeay';
#requires       'WWW::Facebook::API';
requires       'WWW::Lovefilm::API';


# needs expat
requires       'XML::XPath'  => '1.13';
requires       'XML::Twig'   => '3.40';

requires       'WWW::Sitemap::XML';

requires 'YAML::XS';
#requires 'Catalyst::Dotcloud';

requires 'Catalyst::Devel';
requires 'Catalyst::Runtime' => '5.90001';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Plugin::StackTrace';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Model::REST';
requires 'Catalyst::View::TT';
requires 'Template::AutoFilter';
requires 'Catalyst::Action::RenderView';
requires 'Role::REST::Client';
requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::Model::DBIC::Schema';


requires 'Catalyst::Authentication::Credential::Facebook::OAuth2';
requires 'Facebook::Graph';

requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats


requires 'Cache::File';


test_requires  'Test::More'  => '0.98';

#recommends     'Text::CSV_XS'=> '0.50';
#no_index       'directory'   => 'demos';
#install_script 'myscript';

WriteAll;

