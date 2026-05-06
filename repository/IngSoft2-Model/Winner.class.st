"
this class represent when a game has a winner.
"
Class {
	#name : 'Winner',
	#superclass : 'Object',
	#instVars : [
		'winner'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Winner class >> with: name [

	^ self new initializeWith: name
]

{ #category : 'testing' }
Winner >> hasWon [

	^ true
]

{ #category : 'initialization' }
Winner >> initializeWith: name [

	winner := name
]

{ #category : 'accessing' }
Winner >> winner [

	^ winner
]
