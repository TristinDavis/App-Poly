#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst;

BEGIN { use_ok 'Catalyst::Test', 'App::Poly::Web' }

my $m = Test::WWW::Mechanize::Catalyst->new( catalyst_app => 'App::Poly::Web' );

$m->get_ok( '/' , 'basic request works' );
is( $m->uri->path , '/' , 'at home page' );

$m->get_ok( '/hello_user' , 'request hello_user' );
is( $m->uri->path , '/login' , 'redirect to login' );

$m->submit_form_ok({
  form_id => 'login_form' ,
  fields => {
    username => 'bob' ,
    password => 'bobpw' ,
  } ,
  button => 'submit' ,
} , 'login' );

is( $m->uri->path , '/hello_user' , 'redirect to /hello_user' );
$m->text_contains( 'Hello, user bob!' , 'see expected greeting' );

$m->get_ok( '/' , 'basic request works' );
is( $m->uri->path , '/' , 'at home page' );

$m->get_ok( '/hello_user' , 'request hello_user' );
is( $m->uri->path , '/hello_user' , 'go directly to hello_user' );
$m->text_contains( 'Hello, user bob!' , 'still see expected greeting' );

$m->get_ok( '/logout' );
is( $m->uri->path , '/' , 'back at home page' );

$m->get_ok( '/hello_user' , 'request hello_user' );
is( $m->uri->path , '/login' , 'redirect to login' );

done_testing();
