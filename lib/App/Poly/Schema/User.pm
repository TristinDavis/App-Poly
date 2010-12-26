package App::Poly::Schema::User;

use Moose;
with 'KiokuX::User';

use App::Poly::Schema::Account;
use KiokuDB::Set;
use KiokuDB::Util qw/ set /;
use MooseX::Aliases;
use MooseX::Types::Email qw/ EmailAddress /;

use namespace::autoclean;

has '+id' => ( alias => 'name' );

has email => (
  isa      => EmailAddress ,
  is       => 'ro' ,
  required => 1 ,
);

has accounts => (
  isa     => 'KiokuDB::Set' ,
  is      => 'ro' ,
  lazy    => 1 ,
  default => sub { set() } ,
);

sub add_account {
  my( $self , $account_hash ) = @_;

  $account_hash->{owner} = $self;

  my $account = App::Poly::Schema::Account->new( $account_hash );

  $self->accounts->insert( $account );

  return $account;
}

__PACKAGE__->meta->make_immutable;
1;
