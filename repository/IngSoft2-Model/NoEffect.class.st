"
I represent a board cell without any effect.

Landing on me does not modify the state of any spaceship.
"
Class {
	#name : 'NoEffect',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
NoEffect >> applyTo: aSpaceShip affecting: allShips from: aGame [
	"do nothing"

	
]

{ #category : 'as yet unclassified' }
NoEffect >> effectImpact [

	^ 0
]

{ #category : 'testing' }
NoEffect >> isNoEffect [

	^ true
]
