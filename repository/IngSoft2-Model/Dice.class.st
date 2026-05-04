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
Dice class >> with: aCollectionOfDice [
    ^ self new initializeWith: aCollectionOfDice
]

{ #category : 'initialization' }
Dice >> initializeWith: aCollectionOfDice [
    dice := aCollectionOfDice.
    ^ self
]

{ #category : 'transform' }
Dice >> roll [
    | total |
    total := 0.
    dice do: [ :die | total := total + die roll ].
    ^ total
]
