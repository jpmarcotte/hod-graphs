while (<>) {
	$_ =~ m/(.*) \(([^)]*)\) --- \(([^)]*)\) (.*)/;
	my ($team1, $score1, $score2, $team2) = ($1,$2,$3,$4);
	if ($team1 eq 'BYE' || $team2 eq 'BYE') { next; }
	if ($score1 ne 'NaN' && $score2 ne 'NaN') {
		# regular defeat
		if ($score1 eq '2') {
			$winner = $team1;
			$loser = $team2;
			$edge_style = ($score2 eq '1') ? 'color="black"' : 'color="black:black"';
		} else {
			$winner = $team2;
			$loser = $team1;
			$edge_style = ($score1 eq '1') ? 'color="black"' : 'color="black:black"';
		}
	} else {
		# forfeit
		if ($score1 eq 'NaN' && $score2 ne 'NaN') {
			$winner = $team2;
			$loser = $team1;
		} elsif ($score2 eq 'NaN' && $score1 ne 'NaN') {
			$winner = $team1;
			$loser = $team2;
		}
		$edge_style = 'style="dashed" color="gray"';
	}
	print "\t\"$winner\"\t->\t\"$loser\"\t[ $edge_style ]\n";
}
