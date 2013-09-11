package Lingua::Base::Number::Format::MixWithWords;

use 5.010;
use strict;
use warnings;

use Math::Round qw(nearest);
use Number::Format;
use POSIX qw(floor ceil log10);

our $VERSION = '0.07'; # VERSION

our %SPEC;

sub new {
    my ($class, %args) = @_;
    $args{min_fraction} //= 1;
    $args{min_format}   //= 1000000;

    die "Invalid min_fraction, must be 0 < x <= 1"
        unless $args{min_fraction} > 0 && $args{min_fraction} <= 1;
    $args{_nf} = Number::Format->new(
        THOUSANDS_SEP => $args{thousands_sep},
        DECIMAL_POINT => $args{decimal_point},
    );
    $args{powers} = [sort {$a<=>$b} keys %{$args{names}}];
    bless \%args, $class;
}

sub _format {
    my ($self, $num) = @_;
    return undef unless defined $num;

    if (defined $self->{num_decimal}) {
        $num = nearest(10**-$self->{num_decimal}, $num);
    }
    my ($exp, $mts, $exp_f);
    my $anum = abs($num);
    if ($anum) {
        $exp   = floor(log10($anum));
        $mts   = $anum / 10**$exp;
        $exp_f = floor(log10($anum/$self->{min_fraction}));
    } else {
        $exp   = 0;
        $mts   = 0;
        $exp_f = 0;
    }

    my $p;
    my ($res_n, $res_w);
    for my $i (0..@{$self->{powers}}-1) {
        last if $self->{powers}[$i] > $exp_f;
        $p = $self->{powers}[$i];
    }
    if (defined($p) && $anum >= $self->{min_format}*$self->{min_fraction}) {
        $res_n = $mts * 10**($exp-$p);
        $res_w = $self->{names}{$p};
    } else {
        $res_n = $anum;
        $res_w = "";
    }
    # N::F has a limit of 15 num_decimals
    my $e = ceil(log10($res_n)); $e = 0 if $e < 0;
    my $def_nd = 15 - $e; $def_nd = 0 if $def_nd < 0;
    my $nd = $self->{num_decimal} // 15; $nd = 0 if $nd < 0;
    $nd = $def_nd if $nd > $def_nd;
    #print "res_n=$res_n, nd=$nd\n";

    $res_n = $e > 15 ? $res_n : $self->{_nf}->format_number($res_n, $nd);

    ($num < 0 ? "-" : "") . $res_n . ($res_w ? " $res_w" : "");
}

1;
# ABSTRACT: Base class for Lingua::XX::Number::Format::MixWithWords

__END__

=pod

=encoding utf-8

=head1 NAME

Lingua::Base::Number::Format::MixWithWords - Base class for Lingua::XX::Number::Format::MixWithWords

=head1 VERSION

version 0.07

=for Pod::Coverage ^(new)$

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DESCRIPTION

=head1 FUNCTIONS


None are exported by default, but they are exportable.

=cut
