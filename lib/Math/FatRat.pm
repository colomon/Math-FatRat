use Math::BigInt;

class Math::FatRat does Real {
    has $.numerator;
    has $.denominator;

    multi method new() {
        self.bless(*, :numerator(0L), :denominator(1L));
    }

    multi method new(Rat $r) {
        self.bless(*, :numerator(Math::BigInt.new($r.numerator)), 
                      :denominator(Math::BigInt.new($r.denominator)));
    }

    multi method new(Math::BigInt $numerator, Math::BigInt $denominator) {
        my $gcd = gcd($numerator, $denominator);
        self.bless(*, :numerator($numerator div $gcd), :denominator($denominator div $gcd));
    }
    
    # multi method new(Int $numerator is copy, Int $denominator is copy) {
    #     if $denominator < 0 {
    #         $numerator = -$numerator;
    #         $denominator = -$denominator;
    #     }
    #     my $gcd = pir::gcd__iii($numerator, $denominator);
    #     $numerator = $numerator div $gcd;
    #     $denominator = $denominator div $gcd;
    #     self.bless(*, :numerator($numerator), :denominator($denominator));
    # }

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
        my $gcd = gcd($a.denominator, $b.denominator);
        Math::FatRat.new($a.numerator * ($b.denominator div $gcd) + $b.numerator * ($a.denominator div $gcd),
                         ($a.denominator div $gcd) * $b.denominator);
    }
}

# multi sub prefix:<->(Math::FatRat $a) {
#     Math::FatRat.new(-$a.numerator, $a.denominator);
# }
# 
# multi sub infix:<+>(Math::FatRat $a, Math::FatRat $b) {
#     my $gcd = pir::gcd__iii($a.denominator, $b.denominator);
#     ($a.numerator * ($b.denominator div $gcd) + $b.numerator * ($a.denominator div $gcd))
#         / (($a.denominator div $gcd) * $b.denominator);
# }
# 
# multi sub infix:<+>(Math::FatRat $a, Int $b) {
#     ($a.numerator + $b * $a.denominator) / $a.denominator;
# }
# 
# multi sub infix:<+>(Int $a, Math::FatRat $b) {
#     ($a * $b.denominator + $b.numerator) / $b.denominator;
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
# multi sub infix:<*>(Math::FatRat $a, Math::FatRat $b) {
#     ($a.numerator * $b.numerator) / ($a.denominator * $b.denominator);
# }
# 
# multi sub infix:<*>(Math::FatRat $a, Int $b) {
#     ($a.numerator * $b) / $a.denominator;
# }
# 
# multi sub infix:<*>(Int $a, Math::FatRat $b) {
#     ($a * $b.numerator) / $b.denominator;
# }
# 
# multi sub infix:</>(Math::FatRat $a, Math::FatRat $b) {
#     ($a.numerator * $b.denominator) / ($a.denominator * $b.numerator);
# }
# 
# multi sub infix:</>(Math::FatRat $a, Int $b) {
#     $a.numerator / ($a.denominator * $b);
# }
# 
# multi sub infix:</>(Int $a, Math::FatRat $b) {
#     ($b.denominator * $a) / $b.numerator;
# }
# 
# multi sub infix:</>(Int $a, Int $b) {
#     Math::FatRat.new($a, $b);
# }
# 
# multi sub infix:<**>(Math::FatRat $a, Int $b) {
#     my $num = $a.numerator ** $b;
#     my $den = $a.denominator ** $b;
#     $num ~~ Int && $den ~~ Int ?? $num / $den !! $a.Bridge ** $b;
# }

# vim: ft=perl6 sw=4 ts=4 expandtab
