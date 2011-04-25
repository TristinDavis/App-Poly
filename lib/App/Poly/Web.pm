package App::Poly::Web;
# ABSTRACT: App::Poly cat app

use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use Catalyst qw/
    -Debug
    ConfigLoader
    +CatalystX::SimpleLogin
    Authentication
    Session
    Session::Store::File
    Session::State::Cookie
    Static::Simple
/;

extends 'Catalyst';

__PACKAGE__->config(
  disable_component_resolution_regex_fallback => 1,
);

__PACKAGE__->setup();

1;
