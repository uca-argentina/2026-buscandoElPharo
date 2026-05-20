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
		'tiles'
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
EffectDistribution >> addMoonWalk: aProbability [

	moonWalkEffectProbability := aProbability
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

	"self theSumIsOne."
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
	atomicBombEffectProbability := 0
]

{ #category : 'as yet unclassified' }
EffectDistribution >> percentageOfAtomicBomb [

	^ (tiles select: [ :effect | effect isAtomicBomb ]) size / tiles size
]

{ #category : 'as yet unclassified' }
EffectDistribution >> percentageOfHyperJump [

	^ (tiles select: [ :effect | effect isHyperJump ]) size / tiles size
]

{ #category : 'as yet unclassified' }
EffectDistribution >> percentageOfMoonWalk [

	^ (tiles select: [ :effect | effect isMoonWalk ]) size / tiles size
]

{ #category : 'as yet unclassified' }
EffectDistribution >> percentageOfNoEffect [

	^ (tiles select: [ :effect | effect isNoEffect ]) size / tiles size
]

{ #category : 'as yet unclassified' }
EffectDistribution >> percentageOfSpeedUp [

	^ (tiles select: [ :effect | effect isSpeedUp ]) size / tiles size
]

{ #category : 'as yet unclassified' }
EffectDistribution >> percentageOfWormHole [

	^ (tiles select: [ :effect | effect isWormHole ]) size / tiles size
]

{ #category : 'as yet unclassified' }
EffectDistribution >> tileFor: randomProbability [

	| accumulated |
	accumulated := atomicBombEffectProbability.
	randomProbability < accumulated ifTrue: [ ^ AtomicBomb new ].
	accumulated := accumulated + noEffectProbability.
	randomProbability < accumulated ifTrue: [ ^ NoEffect new ].
	accumulated := accumulated + moonWalkEffectProbability .
	randomProbability < accumulated ifTrue: [ ^ MoonWalk new ].
	accumulated := accumulated + hyperJumpEffectProbability.
	randomProbability < accumulated ifTrue: [ ^ HyperJump new ].
	accumulated := accumulated + wormHoleEffectProbability .
	randomProbability < accumulated ifTrue: [ ^ WormHole new ].
	accumulated := accumulated + speedUpEffectProbability .
	randomProbability < accumulated ifTrue: [ ^ SpeedUp new ].

]
