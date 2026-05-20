Class {
	#name : 'HyperJump',
	#superclass : 'Effect',
	#instVars : [
		'parsecsToMove'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperJump class >> withParsecs: parsecValues [

	^ self new initializeWithParsecs: parsecValues
]

{ #category : 'initialization' }
HyperJump >> initializeWithParsecs: someParsecs [

	parsecsToMove := OrderedCollection new.
	parsecsToMove addAll:
		(someParsecs asSortedCollection: [ :aParsec :anotherParsec |
			 aParsec > anotherParsec ])
]

{ #category : 'testing' }
HyperJump >> isHyperJump [

	^ true
]

{ #category : 'playing' }
HyperJump >> nextParsecJump [

	| nextParsec |
	nextParsec := parsecsToMove first.
	parsecsToMove removeFirst.
	parsecsToMove add: nextParsec.

	^ nextParsec
]
