#!perl

use strict;
use warnings;

use Test::More;
use KiokuX::User::Util qw/ crypt_password /;

use_ok 'App::Poly::Schema::User';

my $user = App::Poly::Schema::User->new(
  id       => 'user1' ,
  email    => 'user1@example.com' ,
  password => crypt_password( 'bad_password' ) ,
);

isa_ok( $user , 'App::Poly::Schema::User' );

is( $user->id , 'user1' , 'id' );
is( $user->name , 'user1' , 'name delegated to id' );
is( $user->email , 'user1@example.com' , 'email' );

ok( $user->check_password( 'bad_password' ) , 'check password' );
ok( ! $user->check_password( 'wrong password' ), 'check wrong password' );

is_deeply( [ $user->accounts->members ] , [] , 'no accounts' );

my $account = $user->add_account({
  name  => 'twitter' ,
  type  => 'Twitter' ,
});

is( $account->name , 'twitter' , 'name' );
is( $account->type , 'Twitter' , 'type' );
is( $account->owner , $user , 'owner'  );

is_deeply( [ $user->accounts->members ] , [ $account ] , 'one account' );

done_testing();
