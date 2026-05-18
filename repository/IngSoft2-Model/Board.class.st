Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'tiles',
		'typeOfCell'
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

{ #category : 'as yet unclassified' }
Board >> cells [

	^ tiles
]

{ #category : 'as yet unclassified' }
Board >> effectOnCell [

	^ typeOfCell effectImpact
]

{ #category : 'initialization' }
Board >> initializeWithCells: squares [

	tiles := squares.
]
