use Math::FatRat;
use Math::BigInt;
use Test;

plan *;

{
    my $a = Math::FatRat.new(1/3) FR+ Math::FatRat.new(1/6);
    isa_ok $a, Math::FatRat, "infix:<FR+> creates a FatRat";
    is ~$a.denominator, ~($a.numerator * 2), "and it's 1/2";
}

{
    my $a = 1/3 FR+ 1/6;
    isa_ok $a, Math::FatRat, "infix:<FR+> creates a FatRat";
    is ~$a.denominator, ~($a.numerator * 2), "and it's 1/2";
}

{
    my $a = 2 FR+ 3L;
    isa_ok $a, Math::FatRat, "infix:<FR+> creates a FatRat";
    is ~$a.numerator, 5, "and it's 5";
    is ~$a.denominator, 1, "and it's 5";
}

{
    my $a = 4 FR* 2L;
    isa_ok $a, Math::FatRat, "infix:<FR*> creates a FatRat";
    is ~$a.numerator, ~($a.denominator * 8), "and it's 8";
}

{
    my $a = 4 FR/ 2L;
    isa_ok $a, Math::FatRat, "infix:<FR/> creates a FatRat";
    is ~$a.numerator, ~($a.denominator * 2), "and it's 2";
}



done;