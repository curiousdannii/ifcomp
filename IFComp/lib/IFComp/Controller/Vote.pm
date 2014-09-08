package IFComp::Controller::Vote;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

IFComp::Controller::Vote - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(2) {
    my ( $self, $c, $entry_id, $score ) = @_;

    my $current_comp = $c->model( 'IFCompDB::Comp' )->current_comp;

    unless ( $c->user ) {
        $c->res->code( 401 );
        $c->res->body( "You can't vote because you're not logged in." );
        return;
    }

    my $entry = $c->model( 'IFCompDB::Entry' )->search(
        {
            id => $entry_id,
            comp => $current_comp->id,
        },
    )->single;

    unless ( $entry && $entry->is_qualified ) {
        $c->res->code( 404 );
        $c->res->body( "Invalid entry ID." );
        return;
    }

    unless ( ( $score =~ /^\d\d?$/ ) && ( $score >= 0 ) && ( $score <= 10 ) ) {
        $c->res->code( 400 );
        $c->res->body( "Invalid score (must be an integer between 0 and 10)." );
        return;
    }

    $score = undef unless $score;

    $c->model( 'IFCompDB::Vote' )->update_or_create(
        {
            score => $score,
            entry => $entry_id,
            user => $c->user->id,
            time => DateTime->now( time_zone => 'UTC' ),
            ip   => $c->req->address,
        },
        {
            key => 'user',
        },
    );

    $c->res->code( 200 );
    $c->res->body( 'OK' );
}



=encoding utf8

=head1 AUTHOR

Jason McIntosh

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
