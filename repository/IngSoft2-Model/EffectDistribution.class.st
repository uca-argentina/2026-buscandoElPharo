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

{ #category : 'as yet unclassified' }
EffectDistribution class >> defaultProbabilities [

	^ Dictionary newFrom: {
			  (NoEffect -> 0.4).
			  (WormHole -> 0.2).
			  (SpeedUp -> 0.2).
			  (MoonWalk -> 0.1).
			  (HyperJump -> 0.08).
			  (AtomicBomb -> 0.02) }
]

{ #category : 'creation' }
EffectDistribution class >> withCells: aNumberOfCells [

	^ self new
		  initializeWithCells: aNumberOfCells
		  andProbabilities: self defaultProbabilities
]

{ #category : 'building' }
EffectDistribution >> build [

	| generatedCells |
	generatedCells := OrderedCollection new.

	(amountOfCells * 0.4) asInteger timesRepeat: [
		generatedCells add: NoEffect new ].

	(amountOfCells * 0.2) asInteger timesRepeat: [
		generatedCells add: WormHole new ].

	(amountOfCells * 0.2) asInteger timesRepeat: [
		generatedCells add: SpeedUp new ].

	(amountOfCells * 0.1) asInteger timesRepeat: [
		generatedCells add: MoonWalk new ].

	(amountOfCells * 0.08) asInteger timesRepeat: [
		generatedCells add: HyperJump new ].

	(amountOfCells * 0.02) asInteger timesRepeat: [
		generatedCells add: AtomicBomb new ].

	^ generatedCells
]

{ #category : 'initialization' }
EffectDistribution >> initializeWithCells: aNumberOfCells andProbabilities: someProbabilities [

	amountOfCells := aNumberOfCells.
	probabilities := someProbabilities
]

{ #category : 'initialization' }
EffectDistribution >> initializeWithProbabilities: effectsProbabilities [

	probabilities := effectsProbabilities
]
