"
I represent a HyperJump effect.

I move a spaceship forward using parsec values in descending order.
After all values are used, the sequence starts again from the beginning.
"
Class {
	#name : 'HyperJump',
	#superclass : 'Effect',
	#instVars : [
		'parsecsToMove',
		'turnManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperJump class >> withParsecs: parsecValues [

	^ self new initializeWithParsecs: parsecValues
]

{ #category : 'playing' }
HyperJump >> applyTo: aSpaceShip affecting: allShips from: aGame [

	aSpaceShip
		advanceBy: turnManager selectParsec
		into: aGame
]

{ #category : 'as yet unclassified' }
HyperJump >> currentParsec [

	^ parsecsToMove first
]

{ #category : 'as yet unclassified' }
HyperJump >> effectImpactOn: aBoard [

	^ aBoard cellsRepresenting: turnManager selectParsec 
]

{ #category : 'initialization' }
HyperJump >> initializeWithParsecs: someParsecs [

	parsecsToMove := someParsecs.
	turnManager := TurnManager madeOf: parsecsToMove.
	
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
