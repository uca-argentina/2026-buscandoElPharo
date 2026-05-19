Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'tiles'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> floatCellsErrorDescription [

	^ 'Board can not be created with float cells'
]

{ #category : 'validation' }
Board class >> invalidCellsErrorDescription [

	^ 'Board can not be created with less than 1 cell'
]

{ #category : 'validation' }
Board class >> negativeCellsErrorDescription [

	^ 'Board can not be created with negative cells'
]

{ #category : 'creation' }
Board class >> withCells: squares [

	squares isEmpty ifTrue: [
		Error signal: self invalidCellsErrorDescription ].

	(squares anySatisfy: [ :cell | cell isNumber and: [ cell < 0 ] ])
		ifTrue: [
			Error signal: self negativeCellsErrorDescription ].

	(squares anySatisfy: [ :cell | cell isFloat ])
		ifTrue: [
			Error signal: self floatCellsErrorDescription ].

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

	| tile effect position |
	tile := tiles at: (newPosition min: self cells).
	effect := tile effectImpact.
	position := newPosition + effect.
	currentSpaceShip advanceBy: position top: self cells from: aGame
]
