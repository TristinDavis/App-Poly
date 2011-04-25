package App::Poly::Web::Controller::Root;
# ABSTRACT: Cat::C::Root
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::ActionRole' }

__PACKAGE__->config(namespace => '');

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body( $c->welcome_message );
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub hello_user : Local Does('NeedsLogin') {
  my ( $self, $c ) = @_;

  my $username = $c->user->id;
  $c->res->body("<h2>Hello, user $username!</h2>");
}

sub end : ActionClass('RenderView') {}

__PACKAGE__->meta->make_immutable;
1;
