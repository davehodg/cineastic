#!/usr/bin/env perl

use strict;
use warnings;
use lib 'lib';
use Catalyst::DotCloud;
use Plack::Builder;


use Digest::SHA1;
use YAML::XS;
use Catalyst::Runtime;
use Catalyst::Plugin::ConfigLoader;
use Catalyst::Plugin::Static::Simple;
use Catalyst::Plugin::StackTrace;
use Catalyst::Plugin::Session::State::Cookie;
use Catalyst::Model::REST;
use Catalyst::View::TT;
use Template::AutoFilter;
use Catalyst::Action::RenderView;
use Role::REST::Client;
use Catalyst::Plugin::Authentication;
use Catalyst::Plugin::Session;
use Catalyst::Plugin::Session::State::Cookie;
use Catalyst::Plugin::Session::Store::FastMmap;
use Catalyst::Authentication::Credential::Facebook::OAuth2;
use Facebook::Graph;
use Moose;
use namespace::autoclean;
use Config::General;


builder {
    enable 'Plack::Middleware::BufferedStreaming';
    Catalyst::DotCloud->psgi_app(@_);
};
