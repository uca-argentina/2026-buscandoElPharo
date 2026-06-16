"
I represent a Cancellation card. When played, I remove a specific active permanent card from the game.
"
Class {
	#name : 'CancellationCard',
	#superclass : 'InstantCard',
	#instVars : [
		'cardToCancel'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CancellationCard class >> cancelling: aPermanentCard [

	^ self new initializeCancelling: aPermanentCard
]

{ #category : 'playing' }
CancellationCard >> cancel: aPermanentCard from: aGame [

	aGame deactivateCard: aPermanentCard
]

{ #category : 'initialization' }
CancellationCard >> initializeCancelling: aPermanentCard [

	cardToCancel := aPermanentCard
]

{ #category : 'playing' }
CancellationCard >> playedBy: aSpaceShip in: aGame [

	aSpaceShip removeCard: self.
	self cancel: cardToCancel from: aGame
]
