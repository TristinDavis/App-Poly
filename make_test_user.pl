#! /opt/perl/bin/perl

use strict;
use warnings;

use lib './lib';

use App::Poly::Model::KiokuDB;

my $m = App::Poly::Model::KiokuDB->new(
  dsn => 'dbi:SQLite:db/foo' ,
  extra_args => { create => 1 } ,
);

{
  my $s = $m->new_scope;

  my $user = $m->new_user({
    id       => 'bob' ,
    email    => 'user1@example.com' ,
    password => 'bobpw' ,
  });
}
