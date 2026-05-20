Class {
	#name : 'MoonWalk',
	#superclass : 'Effect',
	#instVars : [
		'amountOfCellsToMoveBack'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
MoonWalk class >> movingBack: anAmountOfCells [

	^ self new initializeMovingBack: anAmountOfCells
]

{ #category : 'as yet unclassified' }
MoonWalk >> applyTo: aSpaceShip affecting: spaceShips [

	^ self
]

{ #category : 'as yet unclassified' }
MoonWalk >> applyTo: aSpaceShip affecting: allShips from: aGame [

	allShips do: [ :ship |
		ship = aSpaceShip ifFalse: [
			ship
				advanceBy: amountOfCellsToMoveBack negated
				top: aGame boardSize
				from: aGame ] ]
]

{ #category : 'as yet unclassified' }
MoonWalk >> effectImpact [

	^ amountOfCellsToMoveBack negated
]

{ #category : 'initialization' }
MoonWalk >> initializeMovingBack: anAmountOfCells [

	amountOfCellsToMoveBack := anAmountOfCells
]

{ #category : 'testing' }
MoonWalk >> isMoonWalk [

	^ true
]
