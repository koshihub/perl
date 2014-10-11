use strict;
use warnings;

my @board = (0, 0, 0, 0, 0, 0, 0, 0, 0);
my $human = 1;
my $cpu = 2;
my $turn = $human;

sub show_board {
    print("\n");
    for (my $i = 0; $i < 3; $i++) {
	for (my $j = 0; $j < 3; $j++) {
	    my $c = $board[$j + $i * 3];
	    if ($c == 0) {
		print(" ",  $j + $i * 3, " ");
	    }
	    elsif ($c == 1) {
		print(" o ");
	    }
	    elsif ($c == 2) {
		print(" x ");
	    }
	    if ($j != 2) {
		print("|");
	    }
	}
	if ($i != 2) {
	    print("\n---+---+---\n");
	}
    }
    print("\n\n");
}

sub put {
    my ($pos, $move) = @_;
    my $suc = 0;

    if ($board[$pos] != 0) {
	print("already put position\n");
    }
    else {
	$suc = 1;
	$board[$pos] = $move;
    }

    return $suc;
}

sub check_status {
    my $result = 0;
    my @lines = (
	[0, 1, 2], [3, 4, 5], [6, 7, 8],
	[0, 3, 6], [1, 4, 7], [2, 5, 8],
	[0, 4, 8], [2, 4, 6]);

    for (my $i = 0; $i < scalar(@lines); $i++) {
	my @line = @{$lines[$i]};
	my $v0 = $board[$line[0]];
	my $v1 = $board[$line[1]];
	my $v2 = $board[$line[2]];
	if ( $v0 == $v1 && $v1 == $v2 && $v0 != 0 ) {
	    $result = $v0;
	    last;
	}
    }

    if ($result == 0) {
	my $flag = 1;
	for (my $i = 0; $i < 9; $i++) {
	    if ($board[$i] == 0) {
		$flag = 0;
		last;
	    }
	}
	
	if ($flag) {
	    $result = 3;
	}
    }

    return $result;
}


show_board();
while (1) {
    if ($turn == $human) {
	print("where do you put? [0~8]\n:");
	my $input = <STDIN>;
	chomp($input);

	if ($input =~ /^q$/) {
	    print("quit\n");
	    last;
	}
	elsif ($input =~ /^[0-8]$/) {
	    if (put($input, $human)) {
		$turn = $cpu;
	    }
	}
	else {
	    print("invalid input\n");
	}
    }
    else {
	print("cpu put\n");

	my @empty_indexes;
	for (my $i = 0; $i < 9; $i++) {
	    if ($board[$i] == 0) {
		push(@empty_indexes, $i);
	    }
	}

	my $pos = $empty_indexes[rand(scalar(@empty_indexes))];
	put($pos, $cpu);
	$turn = $human;
    }

    show_board();

    my $status = check_status();
    if ($status == $human) {
	print("you win!\n");
	last;
    }
    elsif ($status == $cpu) {
	print("cpu wins!\n");
	last;
    }
    elsif ($status == 3) {
	print("draw!\n");
	last;
    }
}

1;
