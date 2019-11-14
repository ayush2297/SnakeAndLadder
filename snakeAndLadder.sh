#! /bin/bash -x

echo "************welcome to the game of snake and ladder**********"

#Constants
declare INITIAL_PLAYER_POSITION=0

#variables
declare dieResult


dieResult=$(( $((RANDOM%6)) + 1 ))
