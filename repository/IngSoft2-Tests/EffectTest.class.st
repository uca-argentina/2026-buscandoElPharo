Class {
	#name : 'EffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectTest >> test001WhenSpeedUpIsCreatedThenItHasAnImpactOfFour [

	| anEffect |
	anEffect := SpeedUp new.
	self assert: anEffect effectImpact equals: 4
]
