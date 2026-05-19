Class {
	#name : 'DistributionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DistributionTest >> test001WhenDistributionIsCreatedThenEachEffectHasASpecificDistribution [

	| anEffect |
	anEffect := SpeedUp new.
	self assert: anEffect effectImpact equals: 4

]
