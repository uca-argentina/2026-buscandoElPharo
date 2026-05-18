Class {
	#name : 'EffectDistributionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectDistributionTest >> test001WhenEffectDistributionBuildsCellsThenItCreatesTheRequestedAmount [

	| aDistribution generatedCells |
	aDistribution := EffectDistribution withCells: 100.

	generatedCells := aDistribution build.

	self assert: generatedCells size equals: 100
]

{ #category : 'tests' }
EffectDistributionTest >> test002WhenEffectDistributionBuildsCellsThenFortyPercentHaveNoEffect [

	| aDistribution generatedCells noEffectCells |
	aDistribution := EffectDistribution withCells: 100.
	generatedCells := aDistribution build.
	noEffectCells := generatedCells select: [ :effect |
		                 effect class = NoEffect ].
	self assert: noEffectCells size equals: 40
]

{ #category : 'tests' }
EffectDistributionTest >> test003WhenEffectDistributionBuildsCellsThenTwentyPercentHaveSpeedUp [

	| aDistribution generatedCells speedUpCells |
	aDistribution := EffectDistribution withCells: 100.
	generatedCells := aDistribution build.
	speedUpCells := generatedCells select: [ :effect |
		                effect class = SpeedUp ].
	self assert: speedUpCells size equals: 20
]

{ #category : 'tests' }
EffectDistributionTest >> test004WhenEffectDistributionBuildsCellsThenEffectsRespectExpectedDistribution [

	| aDistribution generatedCells |
	aDistribution := EffectDistribution withCells: 100.
	generatedCells := aDistribution build.
	self
		assert:
		(generatedCells select: [ :effect | effect class = NoEffect ]) size
		equals: 40.
	self
		assert:
		(generatedCells select: [ :effect | effect class = SpeedUp ]) size
		equals: 20.
	self
		assert:
		(generatedCells select: [ :effect | effect class = WormHole ]) size
		equals: 20.
	self
		assert:
		(generatedCells select: [ :effect | effect class = MoonWalk ]) size
		equals: 10.
	self
		assert:
		(generatedCells select: [ :effect | effect class = HyperJump ]) size
		equals: 8.
	self
		assert:
		(generatedCells select: [ :effect | effect class = AtomicBomb ])
			size
		equals: 2
]
