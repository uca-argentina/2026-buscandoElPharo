"
I represent an instant card. I can be played at any time during the game, and my effect is applied immediately.
"
Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
InstantCard >> isInstant [

	^ true
]

{ #category : 'testing' }
InstantCard >> isPermanent [

	^ false
]

{ #category : 'playing' }
InstantCard >> playedBy: aSpaceShip [

	aSpaceShip removeCard: self
]

{ #category : 'playing' }
InstantCard >> playedBy: aSpaceShip in: aGame [

	aSpaceShip removeCard: self
]

{ #category : 'playing' }
InstantCard >> replayedBy: aSpaceShip in: aGame [

	self playedBy: aSpaceShip in: aGame
]
