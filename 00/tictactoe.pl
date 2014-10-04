use strict;
use warnings;

my @board = (0, 0, 0, 0, 0, 0, 0, 0, 0);
my $human = 1;
my $cpu = 2;

sub printBoard {
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

while (1) {
    printBoard();
    
    print("where do you put? [0~8]\n:");
    my $input = <STDIN>;
    chomp($input);
    
    if ($input >= 0 && $input <= 8) {
	if ($board[$input] != 0) {
	    print("already put position\n");
	}
	else {
	    $board[$input] = $human;
	}
    }
    else {
	print("invalid input\n");
    }
}

printBoard();
1;
