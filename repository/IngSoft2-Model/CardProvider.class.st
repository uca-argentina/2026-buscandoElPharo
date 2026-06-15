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
