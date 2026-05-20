"
I represent a WormHole effect.

When applied, I move a spaceship four cells backward.
"
Class {
	#name : 'WormHole',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
WormHole >> applyTo: aSpaceShip affecting: allShips from: aGame [

	aSpaceShip advanceBy: -4 top: aGame boardSize from: aGame
]

{ #category : 'as yet unclassified' }
WormHole >> effectImpact [

	^ -4
]

{ #category : 'testing' }
WormHole >> isWormHole [

	^ true
]
