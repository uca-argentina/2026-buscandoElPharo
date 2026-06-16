Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> test001WhenABoardIsCreatedThenItHasCells [

	| aBoard fixedCells |
	fixedCells := OrderedCollection
		              with: NoEffect new
		              with: NoEffect new
		              with: NoEffect new.
	aBoard := Board withCells: fixedCells.

	self assert: aBoard cells equals: 3
]

{ #category : 'tests' }
BoardTest >> test002WhenCellsIsLessThanOneThenBoardCannotBeCreated [

	| fixedCells |
	fixedCells := OrderedCollection new.

	self
		should: [ Board withCells: fixedCells ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: Board invalidCellsErrorDescription ]
]

{ #category : 'tests' }
BoardTest >> test003WhenABoardHasAllCellsWithSpeedUpThenAllCellsEffectsMovesFourCellsForward [

	| aGame tiles aBoard |
	tiles := OrderedCollection
		         with: NoEffect new
		         with: NoEffect new
		         with: SpeedUp new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new.
	aBoard := Board withCells: tiles.
	aGame := PharoGame
		         playedOn: aBoard
		         by: #( 'sombrero' )
		         throwing: (Dice with: { (FixedDie withNumberOfFaces: 3) })
		         laps: 2.
	aGame playTurn.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 1
]

{ #category : 'tests' }
BoardTest >> test004WhenABoardHasAllCellsWithNoEffectThenAllCellsHaveNoImpact [

	| aGame tiles aBoard |
	tiles := OrderedCollection
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new.
	aBoard := Board withCells: tiles.
	aGame := PharoGame
		         playedOn: aBoard
		         by: #( 'sombrero' )
		         throwing: (Dice with: { (FixedDie withNumberOfFaces: 3) })
		         laps: 2.
	aGame playTurn.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 3
]

{ #category : 'tests' }
BoardTest >> test005WhenABoardHasAllCellsWithWormHoleThenAllCellsEffectsMovesFourCellsBackwards [

	| aGame tiles aBoard |
	tiles := OrderedCollection
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: WormHole new.
	aBoard := Board withCells: tiles.
	aGame := PharoGame
		         playedOn: aBoard
		         by: #( 'sombrero' )
		         throwing: (Dice with: { (FixedDie withNumberOfFaces: 6) })
		         laps: 2.
	aGame playTurn.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 2
]

{ #category : 'tests' }
BoardTest >> test006WhenABoardIsCreatedThenReceivesAnAlreadyDistributedCollectionOfCells [

	| distribution tiles aBoard |
	distribution := EffectDistribution generateForSize: 100.
	distribution addNoEffect: 0.38.
	distribution addSpeedUp: 0.2.
	distribution addWormHole: 0.2.
	distribution addHyperJump: 0.08.
	distribution addMoonWalk: 0.02.
	distribution addAtomicBomb: 0.02.
	distribution addCardGiver: 0.1.

	tiles := distribution build.
	aBoard := Board withCells: tiles.
	self assert: aBoard cells equals: 100
]

{ #category : 'tests' }
BoardTest >> test007WhenABoardHasDifferentMoonWalksThenEachCellHasItsOwnEffectImpact [

	| tiles aBoard |

    tiles := OrderedCollection
        with: (MoonWalk movingBack: 2)
        with: NoEffect new
        with: (MoonWalk movingBack: 4).
    aBoard := Board withCells: tiles.
    self assert: ((aBoard effectAtCell: 1) effectImpact) equals: -2.
    self assert: ((aBoard effectAtCell: 3) effectImpact) equals: -4
]

{ #category : 'tests' }
BoardTest >> test008WhenABoardHasOneHundredParsecsAndTenCellsThenEachCellRepresentsTenParsecs [

	| aBoard tiles |
	tiles := OrderedCollection new.

	10 timesRepeat: [ tiles add: NoEffect new ].

	aBoard := Board withCells: tiles andParsecs: 100.

	self assert: aBoard parsecsPerCell equals: 10
]

{ #category : 'tests' }
BoardTest >> test009WhenABoardHasTenParsecsPerCellThenTwentyParsecsRepresentTwoCells [

	| aBoard tiles |
	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].

	aBoard := Board withCells: tiles andParsecs: 100.

	self
		assert: (aBoard cellsRepresenting: (Parsec distance: 20))
		equals: 2
]

{ #category : 'tests' }
BoardTest >> test010WhenSpeedUpMovesASpaceShipToAWormHoleCellThenWormHoleIsNotApplied [

	| aGame tiles aBoard |
	tiles := OrderedCollection new.
	2 timesRepeat: [ tiles add: NoEffect new ].
	tiles add: SpeedUp new.
	3 timesRepeat: [ tiles add: NoEffect new ].
	tiles add: WormHole new.
	aBoard := Board withCells: tiles.
	aGame := PharoGame
		         playedOn: aBoard
		         by: #( 'sombrero' )
		         throwing: (Dice with: { (FixedDie withNumberOfFaces: 3) })
		         laps: 2.
	aGame playTurn.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 7
]
