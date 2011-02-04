use Math::FatRat;
use Math::BigInt;
use Test;

plan *;

{
    my $a = Math::FatRat.new(1/3) FR+ Math::FatRat.new(1/6);
    isa_ok $a, Math::FatRat, "infix:<+> creates a FatRat";
    is ~$a.nude, ~<1 2>, "and it's 1/2";
}


done;