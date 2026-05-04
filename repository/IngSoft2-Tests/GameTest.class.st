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
GameTest >> test002WhenAGameHasAlreadyBeenPlayedThenSimulationCanNotRestart [
	
	| aGame |
	aGame := Game createSimulation.
	aGame playTurn.
	aGame playTurn.
	self
		should: [
			aGame playTurn.]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Can not restart the game' ]
]

{ #category : 'tests' }
GameTest >> test003WhenAGameHasCompletedSequenceOfSquaresThenGameIsFinished [

	| aGame squares |
	squares := 4.
	aGame := Game createSimulationWith: squares.
	aGame playTurn.
	self assert: aGame finished equals: true.
]

{ #category : 'tests' }
GameTest >> test004WhenAGameHasAThrowLargerThanSquaresThenGameKeepsPlayingUntilFinished [

	| aGame squares |
	squares := 10.
	aGame := Game createSimulationWith: squares.
	aGame playTurn.
	aGame playTurn.
	self assert: aGame finished equals: true.
]

{ #category : 'tests' }
GameTest >> test005WhenGamePlayATurnThenGameKnowsShipsPosition [

	| aGame squares |
	squares := 10.
	aGame := Game createSimulationWith: squares.
	aGame playTurn.
	self
		assert: (aGame currentPositionOfShip: 'sombrero')
		equals: 5
]

{ #category : 'tests' }
GameTest >> test006WhenAGameHasMoreThanOneShipThenGameCanPlayTurnUntilFinished [

	| aGame squares |
	squares := 10.
	aGame := Game createSimulationWith: squares andPlayers: (OrderedCollection withAll: {'sombrero' . 'bote'.}).
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: aGame currentPositionOfShips equals: (OrderedCollection withAll: {10. 5.}).
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
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: aGame winner equals: 'sombrero'.
]

{ #category : 'tests' }
GameTest >> test009WhenAGameHasNegativeSquaresThenItCanNotStart [

	| squares |
	squares := -10.
	self
		should: [ Game createSimulationWith: squares ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Can not start game with less than 1 squares' ]
]

{ #category : 'tests' }
GameTest >> test010WhenAGameHasNoPlayersThenItCanNotStart [

	| squares |
	squares := 10.
	self
		should: [
			Game
				createSimulationWith: squares
				andPlayers: (OrderedCollection withAll: {  }) ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Can not start game with no players' ]
]

{ #category : 'tests' }
GameTest >> test011WhenGameUseADiceThenShipsMoveDiceRollResult [

	| aGame squares firstDie secondDie dice |
	
	squares := 10.
	firstDie := FixedDie rolling: 3.
	secondDie := FixedDie rolling: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	aGame := Game createSimulationWith: squares andPlayers: (OrderedCollection withAll: {'sombrero' . 'bote'.}) using: dice.
	aGame playTurn.

	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 8.
]

{ #category : 'tests' }
GameTest >> test012WhenGameHasTwoPlayersThenEachPlayerPlayATurn [

	| aGame squares firstDie secondDie dice |
	
	squares := 10.
	firstDie := FixedDie rolling: 3.
	secondDie := FixedDie rolling: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	aGame := Game createSimulationWith: squares andPlayers: (OrderedCollection withAll: {'sombrero' . 'bote'.}) using: dice.
	aGame playTurn.
	aGame playTurn.

	self assert: aGame currentPositionOfShips equals: #(8 8) asOrderedCollection .
]

{ #category : 'tests' }
GameTest >> test013WhenDiceRollsIsBiggerThanSquaresThenShipFinalPositionIsMaxSquare [

	| aGame squares firstDie secondDie dice |
	
	squares := 10.
	firstDie := FixedDie rolling: 3.
	secondDie := FixedDie rolling: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	aGame := Game createSimulationWith: squares andPlayers: (OrderedCollection withAll: {'sombrero' . 'bote'.}) using: dice.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: aGame finished equals: true.
	self assert: aGame winner equals: 'sombrero'.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals:10
]
