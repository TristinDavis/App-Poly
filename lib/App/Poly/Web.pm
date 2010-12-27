package App::Poly::Web;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple
/;

extends 'Catalyst';

__PACKAGE__->config(
  disable_component_resolution_regex_fallback => 1,
);

__PACKAGE__->setup();

1;
