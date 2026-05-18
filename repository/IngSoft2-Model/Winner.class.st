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

{ #category : 'creation' }
Winner class >> withShip: nameTag [

	^ self new initializeWithShip: nameTag
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
