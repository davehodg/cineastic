#!/usr/bin/perl

use strict;
use warnings;

use DBIx::Class::Schema::Loader;

DBIx::Class::Schema::Loader::make_schema_at(
	'Schema::Movies',
	{ 
#		debug => 1,
		dump_directory => './lib',
#		overwrite_modifications => 1,
	},
	[ 
		'dbi:mysql:dbname=movies',
		'root', 
		'',
		# {  loader_class => 'MyLoader' } # AFAIK not needed
	],
);

__END__

As there appears to be no configuration file, but inline config instead,
the db cx values in this script were taken from package Output::Database.

This module should move out of the root into script/ or etc/ but I'm not
yet clear on how to find the project root.

