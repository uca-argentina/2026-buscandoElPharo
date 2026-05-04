"
Key collaborators:
- Die : The individual elements I roll to get a result.
"
Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'dice'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Dice class >> mustHaveAtLeastOneFixedDieErrorDescription [

	^ 'Dice must have at least one fixed die'
]

{ #category : 'as yet unclassified' }
Dice class >> with: aCollectionOfDice [

	(aCollectionOfDice anySatisfy: [ :die | die isKindOf: FixedDie ])
		ifFalse: [
		self error: self mustHaveAtLeastOneFixedDieErrorDescription ].
	^ self new initializeWith: aCollectionOfDice
]

{ #category : 'initialization' }
Dice >> initializeWith: aCollectionOfDice [

	dice := aCollectionOfDice.
]

{ #category : 'transform' }
Dice >> roll [

	| total |
	
	total := 0.
	dice do: [ :die | total := total + die roll ].
	
	^ total
]
