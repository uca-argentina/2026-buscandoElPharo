Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test001WhenAGameIsCreatedThenASimulationCanStart [
	
	| aGame |
	aGame := Game createSimulation.
	
	self assert: aGame started equals: true.
]

{ #category : 'tests' }
GameTest >> test002WhenAGameHasAlreadyStartedThenSimulationCanNotRestart [
	
	| aGame |
	aGame := Game createSimulation.
	aGame playSimulation.
	self assert: aGame finished equals: true.
]

{ #category : 'tests' }
GameTest >> test003WhenAGameHasCompletedSequenceOfSquaresThenGameIsFinished [

	| aGame squares |
	squares := 4.
	aGame := Game createSimulationWith: squares.
	aGame playSimulation.
	self assert: aGame finished equals: true.
]

{ #category : 'tests' }
GameTest >> test004WhenAGameHasAThrowLargerThanSquaresThenGameKeepsPlayingUntilFinished [

	| aGame squares |
	squares := 10.
	aGame := Game createSimulationWith: squares.
	aGame playSimulation.
	self assert: aGame finished equals: true.
]

{ #category : 'tests' }
GameTest >> test005WhenGameIsFinishedThenGameKnowsShipsFinalPosition [

	| aGame squares |
	squares := 10.
	aGame := Game createSimulationWith: squares.
	aGame playSimulation .
	self assert: aGame currentPositionOfShips equals: (OrderedCollection withAll: {15.}).
]

{ #category : 'tests' }
GameTest >> test006WhenAGameHasMoreThanOneShipThenGameKeepsPlayingUntilFinished [

	| aGame squares |
	squares := 10.
	aGame := Game createSimulationWith: squares andPlayers: (OrderedCollection withAll: {'sombrero' . 'bote'.}).
	aGame playSimulation.
	self assert: aGame currentPositionOfShips equals: (OrderedCollection withAll: {15. 10.}).
]

{ #category : 'tests' }
GameTest >> test007WhenAGameHasNotStartedThenTheGameHasNoWinner [

	| aGame squares |
	
	squares := 10.
	aGame := Game createSimulationWith: squares andPlayers: (OrderedCollection withAll: {'sombrero' . 'bote'.}).
	
	self assert: aGame winner equals: 'nobody'.
]

{ #category : 'tests' }
GameTest >> test008WhenAGameIsFinishedThenTheGameKnowsTheWinner [

	| aGame squares |
	
	squares := 10.
	aGame := Game createSimulationWith: squares andPlayers: (OrderedCollection withAll: {'sombrero' . 'bote'.}).
	aGame playSimulation.
	self assert: aGame winner equals: 'sombrero'.
]
