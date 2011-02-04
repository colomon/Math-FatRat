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

{
    is_approx Math::FatRat.new(17/15).Bridge, 17/15, "FatRat.Bridge has correct value (approximately)";
    isa_ok Math::FatRat.new(17/15).Bridge, Num, "FatRat.Bridge has correct type";
}

{
    is Math::FatRat.new(17/15).Bool, Bool::True, "FatRat.Bool has correct value";
    isa_ok Math::FatRat.new(17/15).Bool, Bool, "FatRat.Bool has correct type";
    is Math::FatRat.new(0/15).Bool, Bool::False, "FatRat.Bool has correct value";
    isa_ok Math::FatRat.new(0/15).Bool, Bool, "FatRat.Bool has correct type";
    
}

{
    is_approx Math::FatRat.new(57/2).Num, 57/2, "FatRat.Num has correct value (approximately)";
    isa_ok Math::FatRat.new(57/2).Num, Num, "FatRat.Num has correct type";
}

{
    my $a = Math::FatRat.new(57/2);
    my $b = $a.succ;
    isa_ok $b, Math::FatRat, "FatRat.succ yields a FatRat";
    is ~$b.nude, ~<59 2>, "and the correct value";
    is ~$a.nude, ~<57 2>, "and the original is unchanged";

    $a = $b.pred;
    isa_ok $b, Math::FatRat, "FatRat.pred yields a FatRat";
    is ~$a.nude, ~<57 2>, "and the correct value";
    is ~$b.nude, ~<59 2>, "and the original is unchanged";
}

{
    my $a = Math::FatRat.new(6L,9L);
    isa_ok $a, Math::FatRat, "Two BigInt .new yields a FatRat";
    is ~$a.nude, ~<2 3>, "and fraction is properly reduced";
}

done;