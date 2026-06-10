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
EffectTest >> test004WhenHyperJumpIsUsedThenItReturnsTheNextParsecValue [

	| anEffect |
	anEffect := HyperJump withParsecs: (OrderedCollection
			             with: (Parsec distance: 8)
			             with: (Parsec distance: 6)
			             with: (Parsec distance: 4)).
	anEffect nextParsecJump.
	self
		assert: anEffect nextParsecJump distance
		equals: (Parsec distance: 6) distance
]

{ #category : 'tests' }
EffectTest >> test005WhenHyperJumpUsesAllParsecValuesThenItStartsAgainFromTheLargestValue [

	| anEffect |
	anEffect := HyperJump withParsecs: (OrderedCollection
			             with: (Parsec distance: 8)
			             with: (Parsec distance: 6)
			             with: (Parsec distance: 4)).

	self assert: anEffect currentParsec distance equals: 8
]

{ #category : 'tests' }
EffectTest >> test006WhenMoonWalkIsCreatedThenItMovesBackTheGivenAmountOfCells [

	| anEffect |
	anEffect := MoonWalk movingBack: 3.

	self assert: anEffect effectImpact equals: -3
]

{ #category : 'tests' }
EffectTest >> test007WhenAtomicBombIsAppliedThenItMovesSpaceShipsToFirstCell [

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
EffectTest >> test008WhenMoonWalkIsAppliedThenItDoesNotMoveTheSpaceShipThatTriggeredIt [

	| anEffect affectedSpaceShip otherSpaceShip spaceShips aBoard aGame dice tiles |

	anEffect := MoonWalk movingBack: 3.

	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].
	aBoard := Board withCells: tiles.

	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	aGame := PharoGame
		playedOn: aBoard
		by: #( 'sombrero' 'bote' )
		throwing: dice
		laps: 2.

	spaceShips := aGame allShips.
	affectedSpaceShip := spaceShips first.
	otherSpaceShip := spaceShips second.

	affectedSpaceShip advanceBy: 5 top: aBoard cells from: aGame.
	otherSpaceShip advanceBy: 5 top: aBoard cells from: aGame.

	anEffect applyTo: affectedSpaceShip affecting: spaceShips from: aGame.

	self assert: affectedSpaceShip position equals: 5
]

{ #category : 'tests' }
EffectTest >> test009WhenMoonWalkIsAppliedThenItMovesAllOtherSpaceShipsBack [

	| anEffect affectedSpaceShip otherSpaceShip spaceShips aBoard aGame dice tiles |

	anEffect := MoonWalk movingBack: 3.

	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].
	aBoard := Board withCells: tiles.

	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	aGame := PharoGame
		playedOn: aBoard
		by: #( 'sombrero' 'bote' )
		throwing: dice
		laps: 2.

	spaceShips := aGame allShips.
	affectedSpaceShip := spaceShips first.
	otherSpaceShip := spaceShips second.

	affectedSpaceShip advanceBy: 5 top: aBoard cells from: aGame.
	otherSpaceShip advanceBy: 8 top: aBoard cells from: aGame.

	anEffect applyTo: affectedSpaceShip affecting: spaceShips from: aGame.

	self assert: otherSpaceShip position equals: 5
]

{ #category : 'tests' }
EffectTest >> test010WhenMoonWalkHasDifferentAmountThenItMovesOtherSpaceShipsThatAmount [

	| anEffect affectedSpaceShip otherSpaceShip spaceShips aBoard aGame dice tiles |

	anEffect := MoonWalk movingBack: 5.

	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].
	aBoard := Board withCells: tiles.

	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	aGame := PharoGame
		playedOn: aBoard
		by: #( 'sombrero' 'bote' )
		throwing: dice
		laps: 2.

	spaceShips := aGame allShips.
	affectedSpaceShip := spaceShips first.
	otherSpaceShip := spaceShips second.

	affectedSpaceShip advanceBy: 5 top: aBoard cells from: aGame.
	otherSpaceShip advanceBy: 8 top: aBoard cells from: aGame.

	anEffect applyTo: affectedSpaceShip affecting: spaceShips from: aGame.

	self assert: otherSpaceShip position equals: 3
]

{ #category : 'tests' }
EffectTest >> test011WhenAtomicBombIsAppliedThenItsLapsDoesntChange [

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
EffectTest >> test012WhenHyperJumpCalculatesImpactOnBoardThenItConvertsParsecsToCells [

	| anEffect aBoard tiles |
	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].

	aBoard := Board withCells: tiles andParsecs: 100.

	anEffect := HyperJump withParsecs:
		            (OrderedCollection with: (Parsec distance: 20)).

	self assert: (anEffect effectImpactOn: aBoard) equals: 2
]

{ #category : 'tests' }
EffectTest >> test013WhenHyperJumpCalculatesImpactThenBoardConvertsParsecsToCells [

	| anEffect aBoard tiles |
	tiles := OrderedCollection new.
	5 timesRepeat: [ tiles add: NoEffect new ].

	aBoard := Board withCells: tiles andParsecs: 10.

	anEffect := HyperJump withParsecs: (OrderedCollection
			             with: (Parsec distance: 3)
			             with: (Parsec distance: 2)).

	self assert: (anEffect effectImpactOn: aBoard) equals: 2.
	self assert: (anEffect effectImpactOn: aBoard) equals: 1
]

{ #category : 'tests' }
EffectTest >> test014WhenHyperJumpIsAppliedThenTheSpaceShipAdvancesConvertedCells [

	| aBoard tiles aSpaceShip spaceShips aGame dice |
	tiles := OrderedCollection new.
	5 timesRepeat: [
		tiles add: (HyperJump withParsecs: (OrderedCollection withAll: {
						  (Parsec distance: 3).
						  (Parsec distance: 2).
						  (Parsec distance: 1) })) ].
	aBoard := Board withCells: tiles andParsecs: 10.

	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.

	aGame := PharoGame
		         playedOn: aBoard
		         by: spaceShips
		         throwing: dice
		         laps: 2.

	aSpaceShip := aGame allShips at: 1.

	aGame playTurn.

	self assert: aSpaceShip position equals: 3
]

{ #category : 'tests' }
EffectTest >> test015WhenHyperJumpIsAppliedTwiceThenEachApplicationUsesTheNextParsecValue [

	| anEffect aBoard tiles aSpaceShip spaceShips aGame dice |
	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].
	aBoard := Board withCells: tiles andParsecs: 100.
	anEffect := HyperJump withParsecs: (OrderedCollection
			             with: (Parsec distance: 20)
			             with: (Parsec distance: 10)).
	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	aGame := PharoGame
		         playedOn: aBoard
		         by: #( 'sombrero' )
		         throwing: dice
		         laps: 2.
	spaceShips := aGame allShips.
	aSpaceShip := spaceShips first.
	anEffect applyTo: aSpaceShip affecting: spaceShips from: aGame.
	anEffect applyTo: aSpaceShip affecting: spaceShips from: aGame.
	self assert: aSpaceShip position equals: 3
]

{ #category : 'tests' }
EffectTest >> test016WhenHyperJumpIsAppliedThenCurrentParsecAdvancesToTheNextValue [

	| anEffect aBoard tiles aSpaceShip spaceShips aGame |
	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].
	aBoard := Board withCells: tiles andParsecs: 100.
	anEffect := HyperJump withParsecs: (OrderedCollection
			             with: (Parsec distance: 20)
			             with: (Parsec distance: 10)).
	aSpaceShip := SpaceShip namedAfter: 'sombrero'.
	spaceShips := OrderedCollection with: aSpaceShip.
	aGame := PharoGame
		         playedOn: aBoard
		         by: (OrderedCollection with: 'sombrero')
		         throwing: (Dice with: { (FixedDie withNumberOfFaces: 1) })
		         laps: 2.
	anEffect applyTo: aSpaceShip affecting: spaceShips from: aGame.
	self assert: anEffect currentParsec distance equals: 10
]

{ #category : 'tests' }
EffectTest >> test017WhenHyperJumpIsCreatedThenCurrentParsecIsTheLargestOne [

	| anEffect aBoard tiles aSpaceShip spaceShips |
	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].

	aBoard := Board withCells: tiles andParsecs: 100.

	anEffect := HyperJump withParsecs: (OrderedCollection
			             with: (Parsec distance: 20)
			             with: (Parsec distance: 10)).

	aSpaceShip := SpaceShip namedAfter: 'sombrero'.
	spaceShips := OrderedCollection with: aSpaceShip.


	self assert: anEffect currentParsec distance equals: 20
]

{ #category : 'tests' }
EffectTest >> test018WhenMoonWalkMovesAShipPastTheBeginningThenItWrapsAroundBoard [

	| anEffect affectedSpaceShip otherSpaceShip spaceShips aBoard aGame dice tiles |

	anEffect := MoonWalk movingBack: 4.

	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].
	aBoard := Board withCells: tiles.

	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.

	aGame := PharoGame
		playedOn: aBoard
		by: #( 'sombrero' 'bote' )
		throwing: dice
		laps: 2.

	spaceShips := aGame allShips.
	affectedSpaceShip := spaceShips first.
	otherSpaceShip := spaceShips second.

	affectedSpaceShip
		advanceBy: 5
		top: aBoard cells
		from: aGame.

	otherSpaceShip
		advanceBy: 2
		top: aBoard cells
		from: aGame.

	anEffect
		applyTo: affectedSpaceShip
		affecting: spaceShips
		from: aGame.

	self assert: otherSpaceShip position equals: 8
]
