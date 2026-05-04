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

{ #category : 'as yet unclassified' }
FixedDie class >> rolling: aNumberToRoll [

	aNumberToRoll < 1 ifTrue: [
		^ Error signal: 'A fixed die must have at least one face' ].
	^ self new initializeRolling: aNumberToRoll
]

{ #category : 'initialization' }
FixedDie >> initializeRolling: aNumberToRoll [
	fixedRoll := aNumberToRoll.
	^ self
]

{ #category : 'accessing' }
FixedDie >> roll [
	^ fixedRoll
]
