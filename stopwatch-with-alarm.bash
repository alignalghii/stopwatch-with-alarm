#!/bin/bash

TIMEFILE=/tmp/TIME-stopwatch-with-alarm-47634323575553231689;
speak="espeak -ven-us+f1"

if test -f $TIMEFILE;
	then :;
	else > $TIMEFILE;
fi;

if (head -1 $TIMEFILE | grep -q '^[0-9]\+:[0-9]\+$');
	then
		read time < $TIMEFILE;
		m=`sed 's/^\([0-9]\+\):.*/\1/'  $TIMEFILE`;
		s=`sed 's/^.*:\([0-9]\+\)$/\1/' $TIMEFILE`;
		$speak "Continuing from $m minutes $s seconds";
	else
		read -p 'Minutes: ' m;
		read -p 'Seconds: ' s;
		$speak "Time set to $m minutes $s seconds";
fi;
while ((m >= 0));
	do
		echo -en "\r  Time:   $m:$s   ";
		echo "$m:$s" > $TIMEFILE;
		sleep 1;
		if test "$s" -gt 0;
			then
				let s--;
			else
				if test "$m" -eq 1;
					then $speak "$m minute left";
					else $speak "$m minutes left";
				fi;
				let m--;
				let s=59;
		fi;
done;
> $TIMEFILE;
$speak 'End of the game';
echo -en "\r             \r";
