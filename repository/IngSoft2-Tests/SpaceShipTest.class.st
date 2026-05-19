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

	| aGame dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 4) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 10.
	aBoard := Board withCells: generatedCells.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.
	aGame playTurn.

	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 5
]
