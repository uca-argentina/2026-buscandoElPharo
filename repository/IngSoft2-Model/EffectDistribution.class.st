"
I create collections of board effects according to configurable probabilities.

I am responsible for generating effect distributions used to build game boards.
"
Class {
	#name : 'EffectDistribution',
	#superclass : 'Object',
	#instVars : [
		'cells',
		'noEffectProbability',
		'wormHoleEffectProbability',
		'speedUpEffectProbability',
		'moonWalkEffectProbability',
		'hyperJumpEffectProbability',
		'atomicBombEffectProbability',
		'tiles',
		'moonWalkSteps',
		'hyperJumpParsecs'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
EffectDistribution class >> floatCellsErrorDescription [

	^ 'EffectDistribution can not be created with float numbers'
]

{ #category : 'as yet unclassified' }
EffectDistribution class >> generateForSize: squares [

	squares < 0 ifTrue: [
		Error signal: self negativeCellsErrorDescription ].

	squares isFloat ifTrue: [
		Error signal: self floatCellsErrorDescription ].


	^ self new initializeWithSize: squares
]

{ #category : 'validation' }
EffectDistribution class >> negativeCellsErrorDescription [

	^ 'EffectDistribution can not be created with negative cells'
]

{ #category : 'adding' }
EffectDistribution >> addAtomicBomb: aProbability [

	atomicBombEffectProbability := aProbability
]

{ #category : 'adding' }
EffectDistribution >> addHyperJump: aProbability [

	hyperJumpEffectProbability := aProbability
]

{ #category : 'adding' }
EffectDistribution >> addHyperJump: aProbability withParsecs: parsecs [

	hyperJumpEffectProbability := aProbability.
	hyperJumpParsecs := parsecs
]

{ #category : 'adding' }
EffectDistribution >> addMoonWalk: aProbability [

	moonWalkEffectProbability := aProbability
]

{ #category : 'adding' }
EffectDistribution >> addMoonWalk: aProbability movingBack: steps [

	moonWalkEffectProbability := aProbability.
	moonWalkSteps := steps
]

{ #category : 'adding' }
EffectDistribution >> addNoEffect: aProbability [

	noEffectProbability := aProbability
]

{ #category : 'adding' }
EffectDistribution >> addSpeedUp: aProbability [

	speedUpEffectProbability := aProbability
]

{ #category : 'adding' }
EffectDistribution >> addWormHole: aProbability [

	wormHoleEffectProbability := aProbability
]

{ #category : 'building' }
EffectDistribution >> build [

	self theSumIsOne.
	tiles := (1 to: cells) collect: [ :i |
		         self tileFor: Random new next ].
	^ tiles
]

{ #category : 'initialization' }
EffectDistribution >> initializeWithSize: squares [

	tiles := OrderedCollection new.
	cells := squares.
	noEffectProbability := 0.
	wormHoleEffectProbability := 0.
	speedUpEffectProbability := 0.
	moonWalkEffectProbability := 0.
	hyperJumpEffectProbability := 0.
	atomicBombEffectProbability := 0.
	hyperJumpParsecs := OrderedCollection
		                    with: (Parsec distance: 20)
		                    with: (Parsec distance: 10)
		                    with: (Parsec distance: 5)
]

{ #category : 'testing' }
EffectDistribution >> percentageOfAtomicBomb [

	^ (tiles select: [ :effect | effect isAtomicBomb ]) size / tiles size
]

{ #category : 'testing' }
EffectDistribution >> percentageOfHyperJump [

	^ (tiles select: [ :effect | effect isHyperJump ]) size / tiles size
]

{ #category : 'testing' }
EffectDistribution >> percentageOfMoonWalk [

	^ (tiles select: [ :effect | effect isMoonWalk ]) size / tiles size
]

{ #category : 'testing' }
EffectDistribution >> percentageOfNoEffect [

	^ (tiles select: [ :effect | effect isNoEffect ]) size / tiles size
]

{ #category : 'testing' }
EffectDistribution >> percentageOfSpeedUp [

	^ (tiles select: [ :effect | effect isSpeedUp ]) size / tiles size
]

{ #category : 'testing' }
EffectDistribution >> percentageOfWormHole [

	^ (tiles select: [ :effect | effect isWormHole ]) size / tiles size
]

{ #category : 'adding' }
EffectDistribution >> theSumIsOne [

	| sumOfProbabilites |
	sumOfProbabilites := (noEffectProbability + wormHoleEffectProbability
	                      + speedUpEffectProbability
	                      + moonWalkEffectProbability
	                      + hyperJumpEffectProbability
	                      + atomicBombEffectProbability) ceiling.

	sumOfProbabilites = 1 ifFalse: [
		Error signal: 'The Sum Of All Probabilities should be 1' ]
]

{ #category : 'building' }
EffectDistribution >> tileFor: randomProbability [

	| accumulated |
	accumulated := atomicBombEffectProbability.
	randomProbability < accumulated ifTrue: [ ^ AtomicBomb new ].
	accumulated := accumulated + moonWalkEffectProbability.
	randomProbability < accumulated ifTrue: [
		^ MoonWalk movingBack: moonWalkSteps ].
	accumulated := accumulated + hyperJumpEffectProbability.
	randomProbability < accumulated ifTrue: [
		^ HyperJump withParsecs: hyperJumpParsecs ].
	accumulated := accumulated + wormHoleEffectProbability.
	randomProbability < accumulated ifTrue: [ ^ WormHole new ].
	accumulated := accumulated + speedUpEffectProbability.
	randomProbability < accumulated ifTrue: [ ^ SpeedUp new ].
	^ NoEffect new
]
