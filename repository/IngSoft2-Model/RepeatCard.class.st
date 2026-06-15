Class {
	#name : 'RepeatCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model-Cards',
	#package : 'IngSoft2-Model',
	#tag : 'Cards'
}

{ #category : 'as yet unclassified' }
RepeatCard >> playedBy: aSpaceShip in: aGame [

	aSpaceShip removeCard: self.
	aGame repeatLastAppliedEffectOn: aSpaceShip
]
