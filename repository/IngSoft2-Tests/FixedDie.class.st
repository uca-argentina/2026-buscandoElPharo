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

{ #category : 'as yet unclassified' }
FixedDie >> initializeRolling: aNumberToRoll [
	fixedRoll := aNumberToRoll.
	^ self
]

{ #category : 'as yet unclassified' }
FixedDie >> roll [
	^ fixedRoll
]
