"
this class represent when a game has a winner.
"
Class {
	#name : 'Winner',
	#superclass : 'Object',
	#instVars : [
		'winnerShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Winner class >> with: name [

	^ self new initializeWithShip: name
]

{ #category : 'as yet unclassified' }
Winner class >> withShip: name [

	^ self new initializeWithShip: name
]

{ #category : 'testing' }
Winner >> hasWon [

	^ true
]

{ #category : 'initialization' }
Winner >> initializeWith: name [

	winner := name
]

{ #category : 'initialization' }
Winner >> initializeWithShip: name [

	winnerShip := name
]

{ #category : 'accessing' }
Winner >> winner [

	^ winnerShip 
]
