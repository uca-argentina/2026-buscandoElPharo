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
SpaceShipTest >> test002WhenASpaceShipIsCreatedThenItHasAInitialPositionInZero [

	| aSpaceShip |
	aSpaceShip := SpaceShip namedAfter: 'sombrero'.

	self assert: aSpaceShip position equals: 0
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

	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 4
]

{ #category : 'tests' }
SpaceShipTest >> test005WhenASpaceShipPassesTheLastCellThenItReturnsToTheBeginning [

	| aSpaceShip aGame |
	aSpaceShip := SpaceShip namedAfter: 'sombrero'.
	aGame := PharoGame new.
	aSpaceShip advanceBy: 12 top: 10 from: aGame.
	self assert: aSpaceShip position equals: 2
]

{ #category : 'tests' }
SpaceShipTest >> test006WhenASpaceShipPassesTheLastCellThenItsLapCounterIncreases [

	| aSpaceShip aGame |
	aSpaceShip := SpaceShip namedAfter: 'sombrero'.
	aGame := PharoGame new.
	aSpaceShip advanceBy: 12 top: 10 from: aGame.
	self assert: aSpaceShip laps equals: 1
]

{ #category : 'tests' }
SpaceShipTest >> test007WhenASpaceShipIsCreatedThenItHasNoCardsInHand [

	| aSpaceShip |
	aSpaceShip := SpaceShip namedAfter: 'sombrero'.

	self assert: aSpaceShip amountOfCards equals: 0
]

{ #category : 'tests' }
SpaceShipTest >> test008WhenACardIsAddedToASpaceShipThenItHasThatCardInHand [

	| aSpaceShip aCard |
	aSpaceShip := SpaceShip namedAfter: 'sombrero'.
	aCard := InstantCard new.

	aSpaceShip addCard: aCard.

	self assert: aSpaceShip amountOfCards equals: 1
]

{ #category : 'tests' }
SpaceShipTest >> test009WhenASpaceShipHasACardThenItKnowsIt [

	| aSpaceShip aCard |
	aSpaceShip := SpaceShip namedAfter: 'sombrero'.
	aCard := InstantCard new.

	aSpaceShip addCard: aCard.

	self assert: (aSpaceShip hasCard: aCard) equals: true
]
