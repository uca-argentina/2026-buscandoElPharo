"
I am responsible for managing the sequence of turns in the game
"
Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'spaceShipsOrder',
		'currentTurn'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
TurnManager >> currentShip [

	^ (spaceShipsOrder at: currentTurn)
]

{ #category : 'initialization' }
TurnManager >> initializeWithShips: names [

	spaceShipsOrder := names.
	currentTurn := 1.
]

{ #category : 'playing' }
TurnManager >> nextTurn [

	currentTurn := (currentTurn \\ spaceShipsOrder size) + 1
]
