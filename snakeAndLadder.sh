#! /bin/bash -x 

echo "************welcome to the game of snake and ladder**********"

#Constants
declare NO_OF_PLAYERS=2
declare INFINITE_LOOP=1
declare INITIAL_PLAYER_POSITION=0
declare WINNING_POSITION=100
declare NO_PLAY=0
declare LADDER=1
declare SNAKE=2
declare YES=1
declare ONE=1

#arrays and dictionaries
declare -a recordsOfChancesAndPositions
declare -a playersList

#variables
declare dieResult
declare dieRollCounter=0
declare playerPosition=0
declare weHaveAWinner=0
declare player1CurrentPos=0
declare player2CurrentPos=0
declare chancesTakenToWin=0
declare endTheGame=0
declare playerThatWon=0
declare totalChancesPerPlayer=0
declare currentPositionOfThisPlayer=0
declare repeatChanceForLadder=0
declare initialDieRoll=0

function addToRecords(){
	recordsOfChancesAndPositions[$dieRollCounter]=$playerPosition
}

function checkOptions(){
	chosenOption=$((RANDOM%3))
	case $chosenOption in 
		$NO_PLAY)
			playerPosition=$playerPosition;;
		$LADDER)
			repeatChanceForLadder=1
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
	#addToRecords
}

function play(){
   dieResult=$(( $((RANDOM%6)) + 1 ))
   checkOptions
}

function getCurrentPos(){
	indexToReturn=$(($player*$(($totalChancesPerPlayer - 1))))
	echo ${recordsOfChancesAndPositions[$indexToReturn]}
}

#initialize player positions with initial positions (i.e. 0 )
#read -p "enter the number of players : " playersCount
for (( i=1 ; i <= $NO_OF_PLAYERS ; i++ ))
do
	playersList[$i]=$INITIAL_PLAYER_POSITION
done

#start gaming simulations of n players
while [ $INFINITE_LOOP -eq $ONE ]
do
	totalChancesPerPlayer=$(($totalChancesPerPlayer+1))
	for player in ${!playersList[@]}
	do
		dieRollCounter=$(( $dieRollCounter + 1 ))
		if [ $totalChancesPerPlayer -eq $ONE ]
		then
			currentPositionOfThisPlayer=0			
		else		
			currentPositionOfThisPlayer=$(getCurrentPos $player $totalChancesPerPlayer)
		fi		
		playerPosition=$currentPositionOfThisPlayer
		echo position : $playerPosition		
		play
		if [ $weHaveAWinner -eq $YES ]
		then
			addToRecords
			playerThatWon=$player
			chancesTakenToWin=$totalChancesPerPlayer
			totalTimesDieRolled=$(($dieRollCounter+$totalDieRollOffset))
			endTheGame=1
			break
		fi
		if [ $repeatChanceForLadder -eq $YES ]
	   then
	#		getCurrPosOffset=$(($getCurrPosOffset+1))
			totalDieRollOffset=$(($totalDieRollOffset+1))
   	   repeatChanceForLadder=0
   	   play
  		fi
		addToRecords
	done	
	if [ $endTheGame -eq $YES ]
	then
		sleep 3
		break
	fi	
done
