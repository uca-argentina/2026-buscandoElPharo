"
I represent a Redo card. When played, I replicate the exact behavior of the last card played in the game, allowing a new target to be chosen if necessary.
"
Class {
	#name : 'RedoCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model-Cards',
	#package : 'IngSoft2-Model',
	#tag : 'Cards'
}

{ #category : 'playing' }
RedoCard >> playedBy: aSpaceShip in: aGame [

	aSpaceShip removeCard: self.
	aGame redoLastPlayedCardFor: aSpaceShip
]

{ #category : 'as yet unclassified' }
RedoCard >> shouldBeRememberedAsLastPlayedCard [

	^ false
]
