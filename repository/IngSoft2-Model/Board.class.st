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

	squares isEmpty ifTrue: [ Error signal: self invalidCellsErrorDescription ].
	^ self new initializeWithCells: squares
]

{ #category : 'accessing' }
Board >> cells [

	^ tiles size
]

{ #category : 'playing' }
Board >> effectAtCell: aCellNumber [

	^ (tiles at: aCellNumber) effectImpact 
]

{ #category : 'initialization' }
Board >> initializeWithCells: squares [

	tiles := squares.
]

{ #category : 'playing' }
Board >> movingTo: newPosition crossMaxCellFor: currentSpaceShip from: aGame [

	currentSpaceShip advanceBy: newPosition top: self cells from: aGame
]
