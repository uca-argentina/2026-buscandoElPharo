Class {
	#name : 'SpaceShipManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceShipManagerTest >> test001WhenSpaceShipManagerHasSpaceShipThenItCanKnowItsPosition [

	| aTurnManager spaceShips |
	spaceShips := OrderedCollection withAll: {
			              (SpaceShip namedAfter: 'sombrero').
			              (SpaceShip namedAfter: 'bote') }.
	aTurnManager := SpaceShipsManager withShips: spaceShips.
	self assert: (aTurnManager positionOf: 'sombrero') equals: 0
]

{ #category : 'tests' }
SpaceShipManagerTest >> test002WhenSpaceShipManagerHasSpaceShipThenItCanKnowItsLap [

	| aTurnManager spaceShips |
	spaceShips := OrderedCollection withAll: {
			              (SpaceShip namedAfter: 'sombrero').
			              (SpaceShip namedAfter: 'bote') }.
	aTurnManager := SpaceShipsManager withShips: spaceShips.
	self assert: (aTurnManager lapOf: 'sombrero') equals: 0
]
