"
I am a standard random die used for ship movement.
"
Class {
	#name : 'Die',
	#superclass : 'Object',
	#instVars : [
		'numberOfFaces'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
Die class >> dieFacesErrorDescription [

	^ 'A die must have at least three faces'
]

{ #category : 'validation' }
Die class >> invalidNumberOfFacesErrorDescription [

	^ 'A die must have at least three faces'
]

{ #category : 'creation' }
Die class >> withNumberOfFaces: aNumberOfFaces [

	aNumberOfFaces <= 3 ifTrue: [
		Error signal: self invalidNumberOfFacesErrorDescription ].
	^ self new initializeWithNumberOfFaces: aNumberOfFaces
]

{ #category : 'initialization' }
Die >> initializeWithNumberOfFaces: aNumberOfFaces [

	numberOfFaces := aNumberOfFaces.
]

{ #category : 'accessing' }
Die >> numberOfFaces [

	^ numberOfFaces
]

{ #category : 'transform' }
Die >> roll [

	^ numberOfFaces atRandom
]
