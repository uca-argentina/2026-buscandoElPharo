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

{ #category : 'playing' }
WormHole >> applyTo: aSpaceShip affecting: allShips from: aGame [

	aSpaceShip advanceBy: -4 top: aGame boardSize from: aGame.
	aGame rememberAppliedEffect: self
]

{ #category : 'testing' }
WormHole >> effectImpact [

	^ -4
]

{ #category : 'testing' }
WormHole >> isWormHole [

	^ true
]
