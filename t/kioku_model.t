#! perl

use strict;
use warnings;

use Test::More;

use_ok 'App::Poly::Model::KiokuDB';

my $m = App::Poly::Model::KiokuDB->new( dsn => 'hash' );

{
  my $s = $m->new_scope;

  my $user = $m->new_user({
    id       => 'user1' ,
    email    => 'user1@example.com' ,
    password => 'bad_password' ,
  });

  isa_ok( $user , 'App::Poly::Schema::User' );

  my $user2 = $m->lookup( $user->kiokudb_object_id );
  isa_ok( $user2 , 'App::Poly::Schema::User' );

  is_deeply( $user , $user2 , 'same thing' );

  is( $user->id , 'user1' , 'id' );
  is( $user->email , 'user1@example.com' , 'email' );
  ok( $user->check_password( 'bad_password' ) , 'password' );
  ok( ! $user->check_password( 'wrong_password' ) , '!password' );

  is_deeply( [ $user->accounts->members ]  , [] , 'no accounts' );

  my $account = $m->add_account_to_user( $user , {
    name  => 'twitter' ,
    type  => 'Twitter' ,
  });

  is( $account->name , 'twitter' , 'name' );
  is( $account->type , 'Twitter' , 'type' );
  is( $account->owner , $user , 'owner'  );

  is_deeply( [ $user->accounts->members ] , [ $account ] , 'one account' );
}

done_testing();
