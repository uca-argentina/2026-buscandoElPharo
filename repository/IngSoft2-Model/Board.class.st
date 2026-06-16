"
I represent the game board.

I contain a collection of cells with effects and provide access to them during gameplay.
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'tiles',
		'totalParsecs',
		'parsecsPerCell'
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

{ #category : 'as yet unclassified' }
Board class >> withCells: cells andParsecs: parsecs [

	cells isEmpty ifTrue: [
		Error signal: self invalidCellsErrorDescription ].
	^ self new initializeWithCells: cells andParsecs: parsecs
]

{ #category : 'accessing' }
Board >> cells [

	^ tiles size
]

{ #category : 'playing' }
Board >> cellsRepresenting: aDistance [

	^ (aDistance asParsecs / self parsecsPerCell) ceiling
]

{ #category : 'playing' }
Board >> effectAtCell: aCellNumber [

	^ tiles at: (aCellNumber min: self cells)
]

{ #category : 'initialization' }
Board >> initializeWithCells: squares [

	tiles := squares.
]

{ #category : 'initialization' }
Board >> initializeWithCells: cells andParsecs: aTotalParsecs [

    tiles := cells.
    totalParsecs := aTotalParsecs
]

{ #category : 'playing' }
Board >> parsecsPerCell [

    ^ totalParsecs / self cells
]
