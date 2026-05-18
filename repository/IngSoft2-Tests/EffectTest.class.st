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

{ #category : 'tests' }
EffectTest >> test002WhenNoEffectIsCreatedThenItHasNoImpact [ 

	| anEffect |
	anEffect := NoEffect new.
	self assert: anEffect effectImpact equals: 0
]

{ #category : 'tests' }
EffectTest >> test003WhenWormHoleIsCreatedThenItHasAnImpactOfMinusFour [

	| anEffect |
	anEffect := WormHole new.
	self assert: anEffect effectImpact equals: -4
]
