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

	| aBoard fixedCells |
	fixedCells := OrderedCollection
		              with: SpeedUp new
		              with: SpeedUp new
		              with: SpeedUp new.
	aBoard := Board withCells: fixedCells.

	self assert: (aBoard effectAtCell: 1) equals: 4
]

{ #category : 'tests' }
BoardTest >> test004WhenABoardHasAllCellsWithNoEffectThenAllCellsHaveNoImpact [

	| aBoard fixedCells |
	fixedCells := OrderedCollection
		              with: SpeedUp new
		              with: SpeedUp new
		              with: SpeedUp new.
	aBoard := Board withCells: fixedCells.

	self assert: (aBoard effectAtCell: 1) equals: 4
]

{ #category : 'tests' }
BoardTest >> test005WhenABoardHasAllCellsWithWormHoleThenAllCellsEffectsMovesFourCellsBackwards [

	| aBoard fixedCells |
	fixedCells := OrderedCollection
		              with: WormHole new
		              with: WormHole new
		              with: WormHole new.
	aBoard := Board withCells: fixedCells.
	
	self assert: (aBoard effectAtCell: 1) equals: -4
]

{ #category : 'tests' }
BoardTest >> test006WhenABoardIsCreatedThenReceivesAnAlreadyDistributedCollectionOfCells [
	| distribution probabilities generatedCells aBoard |
	
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 0.4.
	probabilities at: SpeedUp put: 0.6.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 100. 
	aBoard := Board withCells: generatedCells.
	
	self assert: aBoard cells equals: 100.
	"lograr llevar esta logica a PharoGame"
]
