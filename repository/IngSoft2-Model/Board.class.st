"
I represent the game board.

I contain a collection of cells with effects and provide access to them during gameplay.
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'tiles'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
Board class >> invalidCellsErrorDescription [

	^ 'Board can not be created with less than 1 cell'
]

{ #category : 'creation' }
Board class >> withCells: squares [

	squares isEmpty ifTrue: [
		Error signal: self invalidCellsErrorDescription ].


	^ self new initializeWithCells: squares
]

{ #category : 'accessing' }
Board >> cells [

	^ tiles size
]

{ #category : 'initialization' }
Board >> initializeWithCells: squares [

	tiles := squares.
]

{ #category : 'playing' }
Board >> movingTo: newPosition crossMaxCellFor: currentSpaceShip from: aGame [

	| tile |
	tile := tiles at: (newPosition min: self cells).
	currentSpaceShip moveTo: newPosition top: self cells from: aGame.
	tile applyTo: currentSpaceShip affecting: aGame allShips from: aGame
]
