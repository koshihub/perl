use strict;
use warnings;

my @board = (0, 0, 0, 0, 0, 0, 0, 0, 0);
my $human = 1;
my $cpu = 2;

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

sub cpu_move {
    my @empty_indexes;
    for (my $i = 0; $i < 9; $i++) {
	if ($board[$i] == 0) {
	    push(@empty_indexes, $i);
	}
    }

    my $pos = $empty_indexes[rand(scalar(@empty_indexes))];
    put($pos, $cpu);
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

while (1) {
    show_board();
    
    print("where do you put? [0~8]\n:");
    my $input = <STDIN>;
    chomp($input);

    if ($input =~ /^q$/) {
	print("quit\n");
	last;
    }
    elsif ($input =~ /^[0-8]$/) {
	if (put($input, $human)) {
	    cpu_move();
	}
    }
    else {
	print("invalid input\n");
    }
}

1;
