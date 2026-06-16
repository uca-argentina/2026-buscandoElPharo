"
I am responsible for managing the deck of cards. I provide a sequential and cyclic distribution of cards to the spaceships.
"
Class {
	#name : 'CardProvider',
	#superclass : 'Object',
	#instVars : [
		'cards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardProvider class >> withCards: someCards [

	^ self new initializeWithCards: someCards
]

{ #category : 'initialization' }
CardProvider >> initializeWithCards: someCards [

	cards := OrderedCollection new.
	cards addAll: someCards
]

{ #category : 'initialization' }
CardProvider >> nextCard [

	| nextCard |
	nextCard := cards first.
	cards removeFirst.
	cards add: nextCard.
	^ nextCard
]
