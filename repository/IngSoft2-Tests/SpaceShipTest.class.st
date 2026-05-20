Class {
	#name : 'SpaceShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceShipTest >> test001WhenASpaceShipIsCreatedThenItHasAName [

	| aSpaceShip |
	aSpaceShip := SpaceShip namedAfter: 'sombrero'.

	self assert: aSpaceShip identification equals: 'sombrero'
]

{ #category : 'tests' }
SpaceShipTest >> test002WhenASpaceShipIsCreatedThenItHasAInitialPositionInOne [

	| aSpaceShip |
	aSpaceShip := SpaceShip namedAfter: 'sombrero'.

	self assert: aSpaceShip position equals: 1
]

{ #category : 'tests' }
SpaceShipTest >> test003WhenASpaceShipIsBeingCreatedThenItCannotHaveEmptyName [

	self
		should: [ SpaceShip namedAfter: '' ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: SpaceShip invalidNameErrorDescription ]
]

{ #category : 'tests' }
SpaceShipTest >> test004WhenASpaceShipAdvancesThenItsPositionChanges [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 4) }.
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
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 1.
	aGame playTurn.

	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 5
]
