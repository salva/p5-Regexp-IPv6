# -*- Mode: Perl -*-

use Test::More tests => 22;

use Regexp::IPv6 qw($IPv6_re);

my $good = 1;

my $re = qr/^$IPv6_re$/;

while (<DATA>) {
    chomp;
    next if m/^\s*(?:#.*)?$/;
    if (/^GOOD/) {
	$good = 1;
	next;
    }
    if (/^BAD/) {
	$good = 0;
	next;
    }

    if ($good) {
	ok($_ =~ $re, "good $_");
    }
    else {
	ok($_ !~ $re, "bad $_");
    }
}


__DATA__

GOOD:
::127.0.0.1
::1
2001:0db8:85a3:0000:0000:8a2e:0370:7334
2001:db8:85a3:0:0:8a2e:370:7334
2001:db8:85a3::8a2e:370:7334
2001:0db8:0000:0000:0000:0000:1428:57ab
2001:0db8:0000:0000:0000::1428:57ab
2001:0db8:0:0:0:0:1428:57ab
2001:0db8:0:0::1428:57ab
2001:0db8::1428:57ab
2001:db8::1428:57ab
::ffff:12.34.56.78
::ffff:0c22:384e
2001:0db8:1234:ffff:ffff:ffff:ffff:ffff
2001:0db8:1234:0000:0000:0000:0000:0000
2001:db8:a::123
fc00::
::ffff:0:0
2001::
2001:10::
2001:db8::


BAD:
127.0.0.1
