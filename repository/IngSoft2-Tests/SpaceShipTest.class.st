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

	self assert: aSpaceShip nameTag equals: 'sombrero'
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

	| aSpaceShip |
	aSpaceShip := SpaceShip namedAfter: 'sombrero'.
	aSpaceShip  advanceBy: 4.

	self assert: aSpaceShip position equals: 5
]
