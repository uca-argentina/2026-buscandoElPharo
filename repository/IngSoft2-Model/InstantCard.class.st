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

{ #category : 'as yet unclassified' }
InstantCard >> playedBy: aSpaceShip [

	aSpaceShip removeCard: self
]

{ #category : 'as yet unclassified' }
InstantCard >> playedBy: aSpaceShip in: aGame [

	aSpaceShip removeCard: self
]
