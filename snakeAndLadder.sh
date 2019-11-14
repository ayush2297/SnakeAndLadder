#! /bin/bash -x

echo "************welcome to the game of snake and ladder**********"

#Constants
declare INITIAL_PLAYER_POSITION=0
declare WINNING_POSITION=100
declare NO_PLAY=0
declare LADDER=1
declare SNAKE=2
declare YES=1
declare PLAYER1=0
declare PLAYER2=1

#arrays and dictionaries
declare -a player1DieAndPositionRecords
declare -a player2DieAndPositionRecords

#variables
declare dieResult
declare dieRollCounter=0
declare playerPosition=0
declare weHaveAWinner=0
declare player1CurrentPos=0
declare player2CurrentPos=0
declare chancesTakenToWin=0
declare playerThatWon=0

function checkOptions(){
	chosenOption=$((RANDOM%3))
	case $chosenOption in 
		$NO_PLAY)
			playerPosition=$playerPosition;;
		$LADDER)
			if [ $(($playerPosition + $dieResult)) -le $WINNING_POSITION ]	
			then
				playerPosition=$(( $playerPosition + $dieResult ))
			fi
			if [ $playerPosition -eq $WINNING_POSITION ]
 	  		then
				weHaveAWinner=1
   		fi
			;;
		$SNAKE)
			playerPosition=$(( $playerPosition - $dieResult ))
			if [ $playerPosition -le $INITIAL_PLAYER_POSITION ]
   		then
      		playerPosition=$INITIAL_PLAYER_POSITION
   		fi
			;;
		*)
			;;
	esac
}

function play(){
	dieRollCounter=$(( $dieRollCounter + 1 ))
   dieResult=$(( $((RANDOM%6)) + 1 ))
   checkOptions
}

playerNum=0
while [ $player1CurrentPos -le $WINNING_POSITION ] && [ $player2CurrentPos -le $WINNING_POSITION ]
do
	chanceOf=$(($playerNum%2))
	if [ $chanceOf -eq 0 ]
	then
		playerPosition=$player1CurrentPos
		play
		if [ $playerPosition -le $INITIAL_PLAYER_POSITION ]
   	then
   	   player1DieAndPositionRecords[$dieRollCounter]=$INITIAL_PLAYER_POSITION
	   else
	      player1DieAndPositionRecords[$dieRollCounter]=$playerPosition
	   fi
		player1CurrentPos=$playerPosition
	else
		playerPosition=$player2CurrentPos
		play
		if [ $playerPosition -le $INITIAL_PLAYER_POSITION ]
      then
         player2DieAndPositionRecords[$dieRollCounter]=$INITIAL_PLAYE$
      else
         player2DieAndPositionRecords[$dieRollCounter]=$playerPosition
		fi
		player2CurrentPos=$playerPosition
	fi
	if [ $weHaveAWinner -eq $YES ]
	then
		if [ $chanceOf -eq $PLAYER1 ]
		then
			playerThatWon=1
			chancesTakenToWin=${#player1DieAndPositionRecords[@]}
			break
		else
			playerThatWon=2
			chancesTakenToWin=${#player1DieAndPositionRecords[@]}
			break
		fi
	fi
	playerNum=$(( $playerNum + 1 ))
done
