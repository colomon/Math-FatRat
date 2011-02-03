use Math::FatRat;
use Test;

plan *;

{
    my $a = Math::FatRat.new;
    isa_ok $a, Math::FatRat, "default .new creates a FatRat";
    is ~$a.numerator, "0", "with numerator 0";
    is ~$a.denominator, "1", "and denominator 1";
}





done;