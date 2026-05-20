Class {
	#name : 'EffectDistributionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectDistributionTest >> test001WhenGeneratingCellsWithOneHundredPercentProbabilityThenAllCellsAreOfThatType [

	| distribution tiles |
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	tiles := distribution build.
	self assert: tiles size equals: 10.
	self assert:
		(tiles allSatisfy: [ :effect | effect class = NoEffect ])
]

{ #category : 'tests' }
EffectDistributionTest >> test002WhenGeneratingCellsWithDefaultProbabilitiesThenCellsRespectExpectedPercentages [

	| distribution tiles |
	distribution := EffectDistribution generateForSize: 1500.
	distribution addNoEffect: 0.4.
	distribution addSpeedUp: 0.2.
	distribution addWormHole: 0.2.
	distribution addHyperJump: 0.08.
	distribution addMoonWalk: 0.1.
	distribution addAtomicBomb: 0.02.

	tiles := distribution build.

	self assert:
		(distribution percentageOfNoEffect between: 0.37 and: 0.43).
	self assert:
		(distribution percentageOfWormHole between: 0.18 and: 0.22).
	self assert:
		(distribution percentageOfHyperJump between: 0.06 and: 0.10).
	self assert:
		(distribution percentageOfMoonWalk between: 0.08 and: 0.12).
	self assert:
		(distribution percentageOfSpeedUp between: 0.18 and: 0.22).
	self assert:
		(distribution percentageOfAtomicBomb between: 0.01 and: 0.04)
]

{ #category : 'tests' }
EffectDistributionTest >> test003WhenCellsIsNegativeThenEffectDistributionCannotBeCreated [

	self
		should: [ EffectDistribution generateForSize: -1 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: EffectDistribution negativeCellsErrorDescription ]
]

{ #category : 'tests' }
EffectDistributionTest >> test004WhenCellsContainsFloatNumberThenBoardCannotBeCreated [

	self
		should: [ EffectDistribution generateForSize: 1.5 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: EffectDistribution floatCellsErrorDescription ]
]
