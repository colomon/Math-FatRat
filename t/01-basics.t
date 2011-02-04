use Math::FatRat;
use Math::BigInt;
use Test;

plan *;

{
    my $a = Math::FatRat.new;
    isa_ok $a, Math::FatRat, "default .new creates a FatRat";
    is ~$a.numerator, "0", "with numerator 0";
    is ~$a.denominator, "1", "and denominator 1";
}

{
    my $a = Math::FatRat.new(4/10);
    isa_ok $a, Math::FatRat, ".new(Rat) creates a FatRat";
    is ~$a.numerator, "2", "with numerator 2";
    is ~$a.denominator, "5", "and denominator 5";
    is ~$a.nude, <2 5>, ".nude works";
    
    my $b = $a.perl.eval;
    is ~$b.nude, <2 5>, ".perl.eval works";
}




done;