Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test001WhenAGameIsCreatedThenASimulationCanStart [

	| aGame dice |
	dice := Dice with: { (FixedDie rolling: 6) }.
	aGame := Game
		         playedOn: 4
		         by: (OrderedCollection withAll: { 'sombrero' })
		         throwing: dice.

	self assert: aGame started equals: true
]

{ #category : 'tests' }
GameTest >> test002WhenAGameHasAlreadyBeenPlayedThenSimulationCanNotRestart [
	
	| aGame dice |
	dice := Dice with: { (FixedDie rolling: 3) }.
	aGame := Game
		         playedOn: 4
		         by: (OrderedCollection withAll: { 'sombrero' })
		         throwing: dice.
	aGame playTurn.
	aGame playTurn.
	self
		should: [
			aGame playTurn.]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: aGame restartErrorDescription ]
]

{ #category : 'tests' }
GameTest >> test003WhenAGameHasCompletedSequenceOfSquaresThenGameIsFinished [

	| aGame dice |
	dice := Dice with: { (FixedDie rolling: 6) }.
	aGame := Game
		         playedOn: 4
		         by: (OrderedCollection withAll: { 'sombrero' })
		         throwing: dice.
	aGame playTurn.
	self assert: aGame finished equals: true.
]

{ #category : 'tests' }
GameTest >> test004WhenAGameHasAThrowLargerThanSquaresThenGameKeepsPlayingUntilFinished [

	| aGame dice |
	dice := Dice with: { (FixedDie rolling: 6) }.
	aGame := Game
		         playedOn: 10
		         by: (OrderedCollection withAll: { 'sombrero' })
		         throwing: dice.
	aGame playTurn.
	aGame playTurn.
	self assert: aGame finished equals: true.
]

{ #category : 'tests' }
GameTest >> test005WhenGamePlayATurnThenGameKnowsShipsPosition [

	| aGame dice |
	dice := Dice with: { (FixedDie rolling: 6) }.
	aGame := Game
		         playedOn: 10
		         by: (OrderedCollection withAll: { 'sombrero' })
		         throwing: dice.
	aGame playTurn.
	self
		assert: (aGame currentPositionOfShip: 'sombrero')
		equals: 6
]

{ #category : 'tests' }
GameTest >> test006WhenAGameHasMoreThanOneShipThenGameCanPlayTurnUntilFinished [

	| aGame dice |
	dice := Dice with: { (FixedDie rolling: 6) }.
	aGame := Game
		         playedOn: 10
		         by: (OrderedCollection withAll: { 'sombrero'. 'bote' })
		         throwing: dice.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: aGame currentPositionOfShips equals: (OrderedCollection withAll: {10. 6.}).
]

{ #category : 'tests' }
GameTest >> test007WhenAGameHasNotStartedThenTheGameHasNoWinner [

	| aGame dice |
	dice := Dice with: { (FixedDie rolling: 6) }.
	aGame := Game
		         playedOn: 10
		         by: (OrderedCollection withAll: { 'sombrero'. 'bote' })
		         throwing: dice.
	
	self deny: aGame hasWinner.
]

{ #category : 'tests' }
GameTest >> test008WhenAGameIsFinishedThenTheGameKnowsTheWinner [

	| aGame dice |
	dice := Dice with: { (FixedDie rolling: 6) }.
	aGame := Game
		         playedOn: 10
		         by: (OrderedCollection withAll: { 'sombrero'. 'bote' })
		         throwing: dice.
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
		should: [ 	| aGame dice |
	dice := Dice with: { (FixedDie rolling: 6) }.
	aGame := Game
		         playedOn: -10
		         by: (OrderedCollection withAll: { 'sombrero'. 'bote' })
		         throwing: dice. ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: Game invalidSquaresErrorDescription ]
]

{ #category : 'tests' }
GameTest >> test010WhenAGameHasNoPlayersThenItCanNotStart [

	| squares |
	squares := 10.
	self
		should: [
			| aGame dice |
	dice := Dice with: { (FixedDie rolling: 6) }.
	aGame := Game
		         playedOn: 10
		         by: (OrderedCollection withAll: { })
		         throwing: dice.]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: Game invalidPlayersErrorDescription ]
]

{ #category : 'tests' }
GameTest >> test011WhenGameUseADiceThenShipsMoveDiceRollResult [

	| aGame firstDie secondDie dice |
	firstDie := FixedDie rolling: 3.
	secondDie := FixedDie rolling: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	aGame := Game
		         playedOn: 10
		         by:
		         (OrderedCollection withAll: { 'sombrero'. 'bote' })
		         throwing: dice.
	aGame playTurn.

	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 8
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
	aGame := Game
		         playedOn: 10
		         by:
		         (OrderedCollection withAll: { 'sombrero'. 'bote' })
		         throwing: dice.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame currentPositionOfShips
		equals: #( 8 8 ) asOrderedCollection
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
	aGame := Game playedOn: squares by: (OrderedCollection withAll: {'sombrero' . 'bote'.}) throwing: dice.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: aGame finished equals: true.
	self assert: aGame winner equals: 'sombrero'.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals:10
]

{ #category : 'tests' }
GameTest >> test014WhenGameHasNoWinnerThenWinnerReturnsNobody [

    | aGame dice |
    dice := Dice with: { FixedDie rolling: 3. FixedDie rolling: 3 }.
    aGame := Game
        playedOn: 10
        by: (OrderedCollection withAll: {'sombrero'. 'bote'})
        throwing: dice.

    self assert: aGame winner equals: 'nobody'.
]

{ #category : 'tests' }
GameTest >> test015WhenGameIsFinishedThenFinishedReturnsTrue [

    | aGame dice |
    dice := Dice with: { FixedDie rolling: 5. FixedDie rolling: 5 }.
    aGame := Game
        playedOn: 4
        by: (OrderedCollection withAll: {'sombrero'})
        throwing: dice.
    aGame playTurn.

    self assert: aGame finished.
]

{ #category : 'tests' }
GameTest >> test016WhenGameIsFinishedThenStartedReturnsFalse [

    | aGame dice |
    dice := Dice with: { FixedDie rolling: 5. FixedDie rolling: 5 }.
    aGame := Game
        playedOn: 10
        by: (OrderedCollection withAll: {'sombrero'})
        throwing: dice.
    aGame playTurn.

    self deny: aGame started.
]

{ #category : 'tests' }
GameTest >> test017WhenGameIsFinishedThenItHasAWinner [

    | aGame dice |
    dice := Dice with: { FixedDie rolling: 5 }.
    aGame := Game
        playedOn: 4
        by: (OrderedCollection withAll: {'sombrero'})
        throwing: dice.
    aGame playTurn.

    self assert: aGame hasWinner.
]
