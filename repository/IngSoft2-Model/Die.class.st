Class {
	#name : 'Die',
	#superclass : 'Object',
	#instVars : [
		'numberOfFaces'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Die class >> invalidNumberOfFacesErrorDescription [
    ^ 'A die must have at least one face'
]

{ #category : 'as yet unclassified' }
Die class >> withNumberOfFaces: aNumberOfFaces [
    ^ self new initializeWithNumberOfFaces: aNumberOfFaces
]

{ #category : 'as yet unclassified' }
Die >> initializeWithNumberOfFaces: aNumberOfFaces [
    aNumberOfFaces < 1 ifTrue: [ 
        self error: self class invalidNumberOfFacesErrorDescription ].
    numberOfFaces := aNumberOfFaces.
    ^ self
]

{ #category : 'as yet unclassified' }
Die >> numberOfFaces [
    ^ numberOfFaces
]

{ #category : 'as yet unclassified' }
Die >> roll [
    ^ numberOfFaces atRandom
]
