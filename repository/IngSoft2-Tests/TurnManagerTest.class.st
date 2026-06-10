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
	aTurnManager := TurnManager madeOf: spaceShips.
	self assert: aTurnManager currentEntity equals: 'sombrero'
]

{ #category : 'tests' }
TurnManagerTest >> test001WhenTurnManagerIsCreatedThenTurnStartsAtOne [

	| parsec aTurnManager |
	parsec := OrderedCollection withAll: { 1. 2. 3. 4 }.

	aTurnManager := TurnManager madeOf: parsec.
	self assert: aTurnManager currentTurn equals: 1
]

{ #category : 'tests' }
TurnManagerTest >> test002WhenTurnMovesForwardThenCurrentTurnIsAtTwo [

	| parsec aTurnManager |
	parsec := OrderedCollection withAll: { 1. 2. 3. 4 }.

	aTurnManager := TurnManager madeOf: parsec.
	aTurnManager nextTurn.
	self assert: aTurnManager currentTurn equals: 2
]
