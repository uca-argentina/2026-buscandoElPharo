Class {
	#name : 'EffectDistribution',
	#superclass : 'Object',
	#instVars : [
		'probabilities'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
EffectDistribution >> initializeWithProbabilities: effectsProbabilities [

	probabilities := effectsProbabilities
]
