#<<<
use utf8;
package IFComp::Schema::Result::Session;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

IFComp::Schema::Result::Session

=cut

use strict;
use warnings;


=head1 BASE CLASS: L<IFComp::Schema::Result>

=cut

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'IFComp::Schema::Result';

=head1 TABLE: C<session>

=cut

__PACKAGE__->table("session");

=head1 ACCESSORS

=head2 id

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 72

=head2 expires

  data_type: 'integer'
  is_nullable: 1

=head2 session_data

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "char", default_value => "", is_nullable => 0, size => 72 },
  "expires",
  { data_type => "integer", is_nullable => 1 },
  "session_data",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

#>>>

# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-07-05 11:06:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:l7YUlx5T934XGSgny/Tj7w

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
