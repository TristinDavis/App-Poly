package App::Poly::Web::View::TT;
# ABSTRACT: Cat::V::TT

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

1;
