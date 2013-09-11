package MixWithWords::EN;

use Lingua::EN::Number::Format::MixWithWords;
use Package::Rename qw(link_package);

link_package "Lingua::EN::Number::Format::MixWithWords", "MixWithWords::EN";

our $VERSION = '0.07'; # VERSION

1;
# ABSTRACT: Alias for Lingua::EN::Number::Format::MixWithWords

__END__

=pod

=encoding utf-8

=head1 NAME

MixWithWords::EN - Alias for Lingua::EN::Number::Format::MixWithWords

=head1 VERSION

version 0.07

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DESCRIPTION

=head1 FUNCTIONS


None are exported by default, but they are exportable.

=head2 format_number_mix(%args) -> any

Arguments ('*' denotes required arguments):

=over 4

=item * B<min_format> => I<float> (default: 1000000)

Number must be larger than this to be formatted as mixture of number and word.

=item * B<min_fraction> => I<float> (default: 1)

Whether smaller number can be formatted with 0,x.

If minI<fraction is 1 (the default) or 0.9, 800000 won't be formatted as 0.9
omillion but will be if min>fraction is 0.8.

=item * B<num> => I<float>

The input number to format.

=item * B<num_decimal> => I<int>

Number of decimal points to round.

Can be negative, e.g. -1 to round to nearest 10, -2 to nearest 100, and so on.

=item * B<scale> => I<str>

Pick long or short scale names.

See http://en.wikipedia.org/wiki/LongI<scale#Long>scaleI<countries>and_languages
for details.

=back

Return value:

=cut
