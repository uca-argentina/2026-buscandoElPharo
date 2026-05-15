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

{ #category : 'as yet unclassified' }
Winner class >> withShip: name [

	^ self new initializeWithShip: name
]

{ #category : 'testing' }
Winner >> hasWon [

	^ true
]

{ #category : 'initialization' }
Winner >> initializeWithShip: name [

	winnerShip := name identification 
]

{ #category : 'accessing' }
Winner >> winner [

	^ winnerShip 
]
