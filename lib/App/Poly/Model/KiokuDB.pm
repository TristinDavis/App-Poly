package App::Poly::Model::KiokuDB;
use Moose;
extends 'KiokuX::Model';

use App::Poly::Schema::User;
use KiokuX::User::Util qw/ crypt_password /;

sub new_user {
  my( $self , $user_hash ) = @_;

  defined $user_hash->{password}
    or die "Need password";

  $user_hash->{password} = crypt_password( $user_hash->{password} );

  my $user = App::Poly::Schema::User->new( $user_hash );

  my $id = $self->txn_do(
    sub { $self->store($user) }
  );

  return $user;
}

sub add_account_to_user {
  my( $self , $user , $account_hash ) = @_;

  my $account = $self->txn_do( sub {
    my $account = $user->add_account( $account_hash );
    $self->store( $user );
    return $account;
  });

  return $account;
}

__PACKAGE__->meta->make_immutable;
1;
