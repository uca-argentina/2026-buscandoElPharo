Class {
	#name : 'EffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectTest >> test001WhenSpeedUpIsCreatedThenItHasAnImpactOfFour [

	| anEffect |
	anEffect := SpeedUp new.
	self assert: anEffect effectImpact equals: 4
]

{ #category : 'tests' }
EffectTest >> test002WhenNoEffectIsCreatedThenItHasNoImpact [ 

	| anEffect |
	anEffect := NoEffect new.
	self assert: anEffect effectImpact equals: 0
]

{ #category : 'tests' }
EffectTest >> test003WhenWormHoleIsCreatedThenItHasAnImpactOfMinusFour [

	| anEffect |
	anEffect := WormHole new.
	self assert: anEffect effectImpact equals: -4
]

{ #category : 'tests' }
EffectTest >> test005WhenHyperJumpIsUsedThenItReturnsTheNextParsecValue [

	| anEffect |
	anEffect := HyperJump withParsecs: (OrderedCollection
			             with: (Parsec distance: 8)
			             with: (Parsec distance: 6)
			             with: (Parsec distance: 4)).
	anEffect nextParsecJump.
	self assert: anEffect nextParsecJump equals: (Parsec distance: 6)
]

{ #category : 'tests' }
EffectTest >> test006WhenHyperJumpUsesAllParsecValuesThenItStartsAgainFromTheLargestValue [

	| anEffect |
	anEffect := HyperJump withParsecs: (OrderedCollection
			             with: (Parsec distance: 8)
			             with: (Parsec distance: 6)
			             with: (Parsec distance: 4)).
	anEffect nextParsecJump.
	anEffect nextParsecJump.
	anEffect nextParsecJump.
	self assert: anEffect nextParsecJump equals: (Parsec distance: 8)
]

{ #category : 'tests' }
EffectTest >> test007WhenMoonWalkIsCreatedThenItMovesBackTheGivenAmountOfCells [

	| anEffect |
	anEffect := MoonWalk movingBack: 3.

	self assert: anEffect effectImpact equals: -3
]

{ #category : 'tests' }
EffectTest >> test008WhenAtomicBombIsAppliedThenItMovesASpaceShipToFirstCell [

	| anEffect firstSpaceShip secondSpaceShip spaceShips aGame |
	anEffect := AtomicBomb new.
	firstSpaceShip := SpaceShip namedAfter: 'sombrero'.
	secondSpaceShip := SpaceShip namedAfter: 'bote'.
	aGame := PharoGame new.
	firstSpaceShip advanceBy: 5 top: 10 from: aGame.
	secondSpaceShip advanceBy: 3 top: 10 from: aGame.
	spaceShips := OrderedCollection
		              with: firstSpaceShip
		              with: secondSpaceShip.
	anEffect applyTo: firstSpaceShip affecting: spaceShips from: aGame.
	self assert: firstSpaceShip position equals: 1.
	self assert: secondSpaceShip position equals: 1
]

{ #category : 'tests' }
EffectTest >> test009WhenAtomicBombIsAppliedThenItsLapsDoesntChange [

	| aGame dice aBoard tiles distribution ships |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	distribution := EffectDistribution generateForSize: 5.
	distribution addNoEffect: 0.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 1.
	tiles := distribution build.
	aBoard := Board withCells: tiles.
	ships := OrderedCollection with: 'sombrero'.
	aGame := PharoGame
		         playedOn: aBoard
		         by: ships
		         throwing: dice
		         laps: 3.

	aGame playTurn.

	self assert: (aGame currentLapOfShip: 'sombrero') equals: 1.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 1
]

{ #category : 'tests' }
EffectTest >> test010WhenHyperJumpCalculatesImpactOnBoardThenItConvertsParsecsToCells [

	| anEffect aBoard tiles |
	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].

	aBoard := Board withCells: tiles andParsecs: 100.

	anEffect := HyperJump withParsecs:
		            (OrderedCollection with: (Parsec distance: 20)).

	self assert: (anEffect effectImpactOn: aBoard) equals: 2
]

{ #category : 'tests' }
EffectTest >> test011WhenHyperJumpUsesNextParsecValueThenItConvertsItUsingTheBoard [

	| anEffect aBoard tiles |
	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].

	aBoard := Board withCells: tiles andParsecs: 100.

	anEffect := HyperJump withParsecs: (OrderedCollection
			             with: (Parsec distance: 20)
			             with: (Parsec distance: 10)).

	self assert: (anEffect effectImpactOn: aBoard) equals: 2.
	self assert: (anEffect effectImpactOn: aBoard) equals: 1
]

{ #category : 'tests' }
EffectTest >> test012WhenHyperJumpIsAppliedThenItMovesTheSpaceShipUsingBoardParsecsConversion [

	| anEffect aBoard tiles aSpaceShip spaceShips |
	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].

	aBoard := Board withCells: tiles andParsecs: 100.

	anEffect := HyperJump withParsecs:
		            (OrderedCollection with: (Parsec distance: 20)).

	aSpaceShip := SpaceShip namedAfter: 'sombrero'.
	spaceShips := OrderedCollection with: aSpaceShip.

	anEffect
		applyTo: aSpaceShip
		affecting: spaceShips
		onBoard: aBoard
		from: PharoGame new.

	self assert: aSpaceShip position equals: 2
]

{ #category : 'tests' }
EffectTest >> test013WhenHyperJumpIsAppliedTwiceThenItUsesTheNextParsecValue [

	| anEffect aBoard tiles aSpaceShip spaceShips |
	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].

	aBoard := Board withCells: tiles andParsecs: 100.

	anEffect := HyperJump withParsecs: (OrderedCollection
			             with: (Parsec distance: 20)
			             with: (Parsec distance: 10)).

	aSpaceShip := SpaceShip namedAfter: 'sombrero'.
	spaceShips := OrderedCollection with: aSpaceShip.

	anEffect
		applyTo: aSpaceShip
		affecting: spaceShips
		onBoard: aBoard
		from: PharoGame new.

	anEffect
		applyTo: aSpaceShip
		affecting: spaceShips
		onBoard: aBoard
		from: PharoGame new.

	self assert: aSpaceShip position equals: 3
]

{ #category : 'tests' }
EffectTest >> test014WhenHyperJumpIsAppliedTwiceThenItUsesTheNextParsecValue [

	| anEffect aBoard tiles aSpaceShip spaceShips |
	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].

	aBoard := Board withCells: tiles andParsecs: 100.

	anEffect := HyperJump withParsecs: (OrderedCollection
			             with: (Parsec distance: 20)
			             with: (Parsec distance: 10)).

	aSpaceShip := SpaceShip namedAfter: 'sombrero'.
	spaceShips := OrderedCollection with: aSpaceShip.


	self assert: anEffect currentParsec equals: 20
]

{ #category : 'tests' }
EffectTest >> test015WhenHyperJumpIsAppliedTwiceThenItUsesTheNextParsecValue [

	| anEffect aBoard tiles aSpaceShip spaceShips |
	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].

	aBoard := Board withCells: tiles andParsecs: 100.

	anEffect := HyperJump withParsecs: (OrderedCollection
			             with: (Parsec distance: 20)
			             with: (Parsec distance: 10)).

	aSpaceShip := SpaceShip namedAfter: 'sombrero'.
	spaceShips := OrderedCollection with: aSpaceShip.

	anEffect
		applyTo: aSpaceShip
		affecting: spaceShips
		onBoard: aBoard
		from: PharoGame new.


	self assert: anEffect currentParsec equals: 10
]
