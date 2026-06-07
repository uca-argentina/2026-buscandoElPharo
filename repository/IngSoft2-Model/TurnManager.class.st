Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'listOfEntities',
		'currentTurn',
		'spaceShipsOrder'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
TurnManager class >> madeOf: aCollection [

	^ self new initializeIterator: aCollection
]

{ #category : 'as yet unclassified' }
TurnManager >> currentEntity [

	^ listOfEntities at: currentTurn
]

{ #category : 'accessing' }
TurnManager >> currentTurn [

	^ currentTurn
]

{ #category : 'initialization' }
TurnManager >> initializeIterator: aCollection [

	listOfEntities := aCollection.
	currentTurn := 1
]

{ #category : 'playing' }
TurnManager >> nextTurn [

	currentTurn := (currentTurn \\ listOfEntities size) + 1
]

{ #category : 'playing' }
TurnManager >> playTurnOn: aGame [

	| currentSpaceShip |
	currentSpaceShip := listOfEntities at: currentTurn.
	aGame executeTurnFor: currentSpaceShip.
	self nextTurn
]
