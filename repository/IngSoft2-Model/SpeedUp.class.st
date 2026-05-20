"
I represent a SpeedUp effect.

When applied, I move a spaceship four cells forward.
"
Class {
	#name : 'SpeedUp',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpeedUp >> applyTo: aSpaceShip affecting: allShips from: aGame [

	aSpaceShip advanceBy: 4 top: aGame boardSize from: aGame
]

{ #category : 'as yet unclassified' }
SpeedUp >> effectImpact [

	^ 4
]

{ #category : 'testing' }
SpeedUp >> isSpeedUp [

	^ true
]
