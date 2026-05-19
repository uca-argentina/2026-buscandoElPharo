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

	| aGame dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 4.
	aBoard := Board withCells: generatedCells.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.
	aGame playTurn.

	self assert: aGame currentShip equals: 'bote'
]
