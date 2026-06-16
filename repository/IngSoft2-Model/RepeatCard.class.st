"
I represent a Repeat card. When played, I apply the last executed board cell effect to a specific spaceship.
"
Class {
	#name : 'RepeatCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model-Cards',
	#package : 'IngSoft2-Model',
	#tag : 'Cards'
}

{ #category : 'playing' }
RepeatCard >> playedBy: aSpaceShip in: aGame [

	aSpaceShip removeCard: self.
	aGame repeatLastAppliedEffectOn: aSpaceShip
]
