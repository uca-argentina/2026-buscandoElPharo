Class {
	#name : 'EffectDistribution',
	#superclass : 'Object',
	#instVars : [
		'probabilities',
		'amountOfCells'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
EffectDistribution class >> withProbabilities: effectsProbabilities [

	^ self new initializeWithProbabilities: effectsProbabilities
]

{ #category : 'initialization' }
EffectDistribution >> generateCells: anAmountOfCells [

	| generatedCollection |
	generatedCollection := OrderedCollection new.

	probabilities keysAndValuesDo: [ :effectClass :probability |
		| amountToCreate |
		amountToCreate := (anAmountOfCells * probability) asInteger.

		amountToCreate timesRepeat: [
			generatedCollection add: effectClass new ] ].

	^ generatedCollection shuffled
]

{ #category : 'initialization' }
EffectDistribution >> initializeWithProbabilities: effectsProbabilities [

	probabilities := effectsProbabilities
]
