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

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.
	aGame playTurn.

	self assert: aGame currentShip equals: 'bote'
]
