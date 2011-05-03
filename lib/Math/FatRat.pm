use Math::BigInt;

class Math::FatRat does Real {
    has $.numerator;
    has $.denominator;

    multi method new() {
        self.bless(*, :numerator(0L), :denominator(1L));
    }

    multi method new(Int $r) {
        self.bless(*, :numerator(Math::BigInt.new($r)), 
                      :denominator(1L));
    }

    multi method new(Rat $r) {
        self.bless(*, :numerator(Math::BigInt.new($r.numerator)), 
                      :denominator(Math::BigInt.new($r.denominator)));
    }

    multi method new(Math::FatRat $r) {
        self.bless(*, :numerator($r.numerator), 
                      :denominator($r.denominator));
    }

    multi method new(Math::BigInt $numerator, Math::BigInt $denominator = 1L) {
        my $gcd = gcd($numerator, $denominator);
        # need to deal with sign
        self.bless(*, :numerator($numerator div $gcd), :denominator($denominator div $gcd));
    }

    multi method nude() { $.numerator, $.denominator; }

    multi method perl() { "Math::FatRat.new({ $!numerator.perl }, { $!denominator.perl })"; }

    method Bridge() {
        $!denominator == 0 ?? Inf * $!numerator.sign
                           !! $!numerator.Bridge / $!denominator.Bridge;
    }

    method Bool() { $!numerator != 0 ?? Bool::True !! Bool::False }

    # method Math::FatRat(Real $epsilon = 1.0e-6) { self; }

    method Num() {
        $!denominator == 0 ?? Inf * $!numerator.sign
                           !! $!numerator.Num / $!denominator.Num;
    }

    method succ {
        Math::FatRat.new($!numerator + $!denominator, $!denominator);
    }

    method pred {
        Math::FatRat.new($!numerator - $!denominator, $!denominator);
    }
    
    multi sub infix:<FR+>(Math::FatRat $a, Math::FatRat $b) is export(:DEFAULT) {
        Math::FatRat.new($a.numerator * $b.denominator + $b.numerator * $a.denominator,
                         $a.denominator * $b.denominator);
    }

    multi sub infix:<FR+>($a, $b) is export(:DEFAULT) {
        Math::FatRat.new($a) FR+ Math::FatRat.new($b);
    }

    multi sub infix:<FR*>(Math::FatRat $a, Math::FatRat $b) {
        Math::FatRat.new($a.numerator * $b.numerator, $a.denominator * $b.denominator);
    }

    multi sub infix:<FR*>($a, $b) is export(:DEFAULT) {
        Math::FatRat.new($a) FR* Math::FatRat.new($b);
    }
    
    multi sub infix:<FR/>(Math::FatRat $a, Math::FatRat $b) {
        Math::FatRat.new($a.numerator * $b.denominator, $a.denominator * $b.numerator);
    }

    multi sub infix:<FR/>($a, $b) is export(:DEFAULT) {
        Math::FatRat.new($a) FR/ Math::FatRat.new($b);
    }
}

# multi sub prefix:<->(Math::FatRat $a) {
#     Math::FatRat.new(-$a.numerator, $a.denominator);
# }
# 
# multi sub infix:<->(Math::FatRat $a, Math::FatRat $b) {
#     my $gcd = pir::gcd__iii($a.denominator, $b.denominator);
#     ($a.numerator * ($b.denominator div $gcd) - $b.numerator * ($a.denominator div $gcd))
#         / (($a.denominator div $gcd) * $b.denominator);
# }
# 
# multi sub infix:<->(Math::FatRat $a, Int $b) {
#     ($a.numerator - $b * $a.denominator) / $a.denominator;
# }
# 
# multi sub infix:<->(Int $a, Math::FatRat $b) {
#     ($a * $b.denominator - $b.numerator) / $b.denominator;
# }
# 
# multi sub infix:<**>(Math::FatRat $a, Int $b) {
#     my $num = $a.numerator ** $b;
#     my $den = $a.denominator ** $b;
#     $num ~~ Int && $den ~~ Int ?? $num / $den !! $a.Bridge ** $b;
# }

# vim: ft=perl6 sw=4 ts=4 expandtab
