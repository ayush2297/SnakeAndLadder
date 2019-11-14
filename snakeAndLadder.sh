#! /bin/bash 

echo "************welcome to the game of snake and ladder**********"

#Constants
declare INITIAL_PLAYER_POSITION=0
declare WINNING_POSITION=100
declare NO_PLAY=0
declare LADDER=1
declare SNAKE=2

#arrays and dictionaries
declare -a dieAndPositionRecords

#variables
declare dieResult
declare dieRollCounter=0
declare playerPosition=0

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
			;;
		$SNAKE)
			playerPosition=$(( $playerPosition - $dieResult ));;
		*)
			;;
	esac
}

function incrementByOne(){
	echo $(( $1 + 1 ))
}

while [ $playerPosition -le $WINNING_POSITION ]
do
	if [ $playerPosition -eq $WINNING_POSITION ]
	then
		break
	elif [ $playerPosition -le $INITIAL_PLAYER_POSITION ]
	then
		playerPosition=$INITIAL_PLAYER_POSITION
	fi
	dieRollCounter=$(( $dieRollCounter + 1 ))
	dieResult=$(( $((RANDOM%6)) + 1 ))
	checkOptions
	if [ $playerPosition -le $INITIAL_PLAYER_POSITION ]
   then
      dieAndPositionRecords[$dieRollCounter]=$INITIAL_PLAYER_POSITION
   else
      dieAndPositionRecords[$dieRollCounter]=$playerPosition
   fi

done
chancesTakenToWin=${#dieAndPositionRecords[@]}
for ind in ${!dieAndPositionRecords[@]}
do
	echo " die count : $ind		val: ${dieAndPositionRecords[$ind]}"
done
