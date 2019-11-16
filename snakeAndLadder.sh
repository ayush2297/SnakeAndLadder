#! /bin/bash -x 

echo "************welcome to the game of snake and ladder**********"

#Constants
declare NO_OF_PLAYERS=2
declare INITIAL_PLAYER_POSITION=0
declare WINNING_POSITION=100
declare NO_PLAY=0
declare LADDER=1
declare SNAKE=2
declare YES=1
declare INITIAL_CHANCE=1

#arrays and dictionaries
declare -a recordsOfChancesAndPositions
declare -a playersList

#variables
declare dieResult=0
declare dieRollCounter=0
declare playerPosition=0
declare weHaveAWinner=0
declare totalChancesPerPlayer=0
declare currentPositionOfThisPlayer=0
declare repeatChanceForLadder=0

#add the details of the chance played to the records array
function addToRecords(){
	recordsOfChancesAndPositions[$dieRollCounter]=$1
}

#to decide what the player will do after rolling the die
function checkOptions(){
	chosenOption=$((RANDOM%3))
	case $chosenOption in
		$NO_PLAY)
			;;
		$LADDER)
			repeatChanceForLadder=1
			if [ $(( $1 + $2 )) -le $WINNING_POSITION ]
			then
				playerPosition=$(( $1 + $2 ))
			fi
			if [ $playerPosition -eq $WINNING_POSITION ]
			then
				weHaveAWinner=1
			fi
			;;
		$SNAKE)
			playerPosition=$(( $1 - $2 ))
			if [ $playerPosition -le $INITIAL_PLAYER_POSITION ]
			then
				playerPosition=$INITIAL_PLAYER_POSITION
			fi
			;;
	esac
}

#a player plays its chance by rolling a die
function play(){
	position=$1
	dieResult=$(( $((RANDOM%6)) + 1 ))
	checkOptions $position $dieResult
}

#returns player's current position
function getCurrentPos(){
	indexToReturn=$(($player*$(($totalChancesPerPlayer - 1))))
	echo ${recordsOfChancesAndPositions[$indexToReturn]}
}

#initialize player positions with initial positions (i.e. 0 )
for (( i=1 ; i <= $NO_OF_PLAYERS ; i++ ))
do
	playersList[$i]=$INITIAL_PLAYER_POSITION
done

function checkForLadderRepeatChance(){
	if [ $1 -eq $YES ]
	then
		totalDieRollOffset=$(($totalDieRollOffset+1))
		repeatChanceForLadder=0
		play $playerPosition
		if [ $weHaveAWinner -ne $YES ]
		then
			checkForLadderRepeatChance $repeatChanceForLadder
		fi
	fi
}


#start gaming simulations of n players
function startTheGame()
{
	local currentPositionOfThisPlayer=0
	local endTheGame=0
	totalChancesPerPlayer=$(($totalChancesPerPlayer+1))
	#each player gets to play one chance (one by one)
	for player in ${!playersList[@]}
	do
		plNum=$player
		dieRollCounter=$(( $dieRollCounter + 1 ))
		if [ $totalChancesPerPlayer -eq $INITIAL_CHANCE ]
		then
			currentPositionOfThisPlayer=0
		else
			currentPositionOfThisPlayer=$(getCurrentPos $player $totalChancesPerPlayer)
		fi
		playerPosition=$currentPositionOfThisPlayer
		play $playerPosition
		checkForLadderRepeatChance $repeatChanceForLadder
		if [ $weHaveAWinner -eq $YES ]
		then
			addToRecords $playerPosition
			playerThatWon=$player
			chancesTakenToWin=$totalChancesPerPlayer
			totalTimesDieRolled=$(($dieRollCounter+$totalDieRollOffset))
			endTheGame=1
			break
		fi
		addToRecords $playerPosition
	done
	if [ $endTheGame -ne $YES ]
	then
		startTheGame
	fi
}

startTheGame
