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

{ #category : 'as yet unclassified' }
Dice >> initializeWith: aCollectionOfDice [
    dice := aCollectionOfDice.
    ^ self
]

{ #category : 'as yet unclassified' }
Dice >> roll [
    | total |
    total := 0.
    dice do: [ :die | total := total + die roll ].
    ^ total
]
