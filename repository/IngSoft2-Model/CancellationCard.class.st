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

{ #category : 'as yet unclassified' }
CancellationCard >> cancel: aPermanentCard from: aGame [

	aGame deactivateCard: aPermanentCard
]

{ #category : 'initialization' }
CancellationCard >> initializeCancelling: aPermanentCard [

	cardToCancel := aPermanentCard
]

{ #category : 'as yet unclassified' }
CancellationCard >> playedBy: aSpaceShip in: aGame [

	aSpaceShip removeCard: self.
	self cancel: cardToCancel from: aGame
]
