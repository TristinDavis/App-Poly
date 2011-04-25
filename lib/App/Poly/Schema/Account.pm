package App::Poly::Schema::Account;
# ABSTRACT: Account object
use Moose;

use App::Poly::Schema::User;

use namespace::autoclean;

has name => (
  isa      => 'Str' ,
  is       => 'ro' ,
  required => 1 ,
);

has owner => (
  isa      => 'App::Poly::Schema::User' ,
  is       => 'ro' ,
  required => 1 ,
);

has type => (
  isa      => 'Str' ,
  is       => 'ro' ,
  required => 1 ,
);

__PACKAGE__->meta->make_immutable;
1;
