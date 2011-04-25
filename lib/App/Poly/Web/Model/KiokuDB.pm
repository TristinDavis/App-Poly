package App::Poly::Web::Model::KiokuDB;
# ABSTRACT: Cat::M::KiokuDB wrapper
use Moose;

use App::Poly::Model::KiokuDB;

BEGIN { extends qw(Catalyst::Model::KiokuDB) }

has '+model_class' => ( default => "App::Poly::Model::KiokuDB" );

__PACKAGE__->meta->make_immutable;
1;
