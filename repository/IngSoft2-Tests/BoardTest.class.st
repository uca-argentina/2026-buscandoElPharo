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
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 4
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
	distribution addNoEffect: 0.4.
	distribution addSpeedUp: 0.2.
	distribution addWormHole: 0.2.
	distribution addHyperJump: 0.08.
	distribution addMoonWalk: 0.1.
	distribution addAtomicBomb: 0.02.

	tiles := distribution build.
	aBoard := Board withCells: tiles.

	self assert: aBoard cells equals: 100
]

{ #category : 'tests' }
BoardTest >> test007WhenABoardHasDifferentMoonWalksThenEachCellHasItsOwnEffectImpact [

	| aGame tiles aBoard |
	tiles := OrderedCollection
		         with: NoEffect new
		         with: NoEffect new
		         with: (MoonWalk movingBack: 2).
	aBoard := Board withCells: tiles.
	aGame := PharoGame
		         playedOn: aBoard
		         by: #( 'sombrero' 'bote' )
		         throwing: (Dice with: { (FixedDie withNumberOfFaces: 3) })
		         laps: 2.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 1
]
