Class {
	#name : 'EffectDistributionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectDistributionTest >> test001WhenGeneratingCellsWithOneHundredPercentProbabilityThenAllCellsAreOfThatType [
	| probabilities distribution generatedCells |
	
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1. 	
	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 10. 

	self assert: (generatedCells allSatisfy: [ :cell | cell class = NoEffect ]). "checkear si esta bueno preguntar por la clase"
]

{ #category : 'tests' }
EffectDistributionTest >> test002WhenEffectDistributionBuildsCellsThenFortyPercentHaveNoEffect [

	| probabilities distribution generatedCells noEffectCells |
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.
	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 40.

	noEffectCells := generatedCells select: [ :effect |
		                 effect class = NoEffect ].
	self assert: noEffectCells size equals: 40
]
