"
Key collaborators:
- FixedDie: The individual elements I roll to get a result.
"
Class {
	#name : 'FixedDie',
	#superclass : 'Object',
	#instVars : [
		'fixedRoll'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'validation' }
FixedDie class >> fixedDieFacesErrorDescription [

	^ 'A fixed die must have at least one face'
]

{ #category : 'playing' }
FixedDie class >> withNumberOfFaces: faces [

	faces < 1 ifTrue: [
		^ Error signal: self fixedDieFacesErrorDescription ].
	^ self new initializeRolling: faces
]

{ #category : 'initialization' }
FixedDie >> initializeRolling: aNumberToRoll [

	fixedRoll := aNumberToRoll.
]

{ #category : 'accessing' }
FixedDie >> roll [

	^ fixedRoll
]
