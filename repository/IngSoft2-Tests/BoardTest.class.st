Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> test001WhenABoardIsCreatedThenItHasCells [

	| aBoard |
	aBoard := Board withCells: 10.

	self assert: aBoard cells equals: 10
]

{ #category : 'tests' }
BoardTest >> test002WhenCellsIsLessThanOneThenBoardCannotBeCreated [

	self
		should: [ Board withCells: 0 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: Board invalidCellsErrorDescription ]
]

{ #category : 'tests' }
BoardTest >> test003WhenCellHasSpeednUpThenItCausesAnEffectOfFourCellsForward [

	| aBoard |
	aBoard := Board withCells: 10 andEffect: SpeedUp new.

	self assert: aBoard effectOnCell equals: 4
]
