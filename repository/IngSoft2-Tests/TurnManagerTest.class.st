Class {
	#name : 'TurnManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
TurnManagerTest >> test001WhenTurnManagerIsCreatedThenFirstSpaceShipHasTheTurn [

	| aTurnManager spaceShips |
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	aTurnManager := TurnManager withShips: spaceShips.
	self assert: aTurnManager currentShip equals: 'sombrero'
]

{ #category : 'tests' }
TurnManagerTest >> test002WhenTurnAdvancesThenSecondSpaceShipHasTheTurn [

	| aGame firstDie secondDie dice ships |
	firstDie := FixedDie withNumberOfFaces: 3.
	secondDie := FixedDie withNumberOfFaces: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	ships := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	aGame := PharoGame playedOn: 10 by: ships throwing: dice.
	aGame playTurn.

	self assert: aGame currentShip equals: 'bote'
]
