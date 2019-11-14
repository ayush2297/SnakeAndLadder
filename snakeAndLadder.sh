#! /bin/bash -x

echo "************welcome to the game of snake and ladder**********"

#Constants
declare INITIAL_PLAYER_POSITION=0
declare NO_PLAY=0
declare LADDER=1
declare SNAKE=2

#variables
declare dieResult
declare playerPosition

function checkOptions(){
	chosenOption=$((RANDOM%3))
	case $chosenOption in 
		$NO_PLAY)
			playerPosition=$playerPosition;;
		$LADDER)
			playerPosition=$(( $playerPosition + $dieResult ));;
		$SNAKE)
			playerPosition=$(( $playerPosition + $dieResult ));;
		*)
			;;
	esac
}

dieResult=$(( $((RANDOM%6)) + 1 ))
playerPosition=$INITIAL_PLAYER_POSITION
checkOptions
