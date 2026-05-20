"
I represent a HyperJump effect.

I move a spaceship forward using parsec values in descending order.
After all values are used, the sequence starts again from the beginning.
"
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
