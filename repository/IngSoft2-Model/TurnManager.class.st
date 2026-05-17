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

{ #category : 'creation' }
TurnManager class >> withShips: names [

	^ self new initializeWithShips: names
]

{ #category : 'playing' }
TurnManager >> currentShip [

	^ (spaceShipsOrder at: currentTurn)
]

{ #category : 'accessing' }
TurnManager >> currentShipIdentification [

	^ (spaceShipsOrder at: currentTurn) identification
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

{ #category : 'playing' }
TurnManager >> playTurnOn: aGame [

	| currentSpaceShip |
	currentSpaceShip := spaceShipsOrder at: currentTurn.
	aGame executeTurnFor: currentSpaceShip.
	self nextTurn
]

{ #category : 'accessing' }
TurnManager >> positionOf: aName [

	^ (spaceShipsOrder detect: [ :ship | ship identification = aName ])
		  position
]
