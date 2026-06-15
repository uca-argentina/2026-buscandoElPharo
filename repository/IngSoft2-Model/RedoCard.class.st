Class {
	#name : 'RedoCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model-Cards',
	#package : 'IngSoft2-Model',
	#tag : 'Cards'
}

{ #category : 'as yet unclassified' }
RedoCard >> playedBy: aSpaceShip in: aGame [

	aSpaceShip removeCard: self.
	aGame redoLastPlayedCardFor: aSpaceShip
]

{ #category : 'as yet unclassified' }
RedoCard >> shouldBeRememberedAsLastPlayedCard [

	^ false
]
