Class {
	#name : 'PharoGameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PharoGameTest >> CHECKEARtest018WhenTwoSpaceShipsAreBeingCreatedThenTheyCannotHaveTheSameName [

	| firstSpaceShip |
	firstSpaceShip := SpaceShip namedAfter: 'sombrero'.
	self
		should: [ SpaceShip namedAfter: 'sombrero' ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: SpaceShip repeatedNameErrorDescription ]
]

{ #category : 'tests' }
PharoGameTest >> test001WhenAGameIsCreatedThenASimulationCanStart [

	| aGame dice |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	aGame := PharoGame
		         playedOn: 4
		         by: (OrderedCollection withAll: { 'sombrero' })
		         throwing: dice.

	self assert: aGame started equals: true
]

{ #category : 'tests' }
PharoGameTest >> test002WhenAGameHasAlreadyBeenFinishedThenSimulationCanNotReplay [
	
	| aGame dice |
	dice := Dice with: { (FixedDie withNumberOfFaces: 3) }.
	aGame := PharoGame
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
PharoGameTest >> test003WhenAGameHasCompletedSequenceOfSquaresThenGameIsFinished [

	| aGame dice |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	aGame := PharoGame
		         playedOn: 4
		         by: (OrderedCollection withAll: { 'sombrero' })
		         throwing: dice.
	aGame playTurn.
	self assert: aGame finished equals: true.
]

{ #category : 'tests' }
PharoGameTest >> test004WhenAGameHasAThrowLargerThanSquaresThenGameKeepsPlayingUntilFinished [

	| aGame dice |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	aGame := PharoGame
		         playedOn: 10
		         by: (OrderedCollection withAll: { 'sombrero' })
		         throwing: dice.
	aGame playTurn.
	aGame playTurn.
	self assert: aGame finished equals: true.
]

{ #category : 'tests' }
PharoGameTest >> test005WhenGamePlayATurnThenGameKnowsSpaceShipsPosition [

	| aGame dice |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	aGame := PharoGame
		         playedOn: 10
		         by: (OrderedCollection withAll: { 'sombrero' })
		         throwing: dice.
	aGame playTurn.
	self
		assert: (aGame currentPositionOfShip: 'sombrero')
		equals: 6
]

{ #category : 'tests' }
PharoGameTest >> test006WhenAGameHasMoreThanOneSpaceShipThenGameCanPlayTurnUntilFinished [

	| aGame dice |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	aGame := PharoGame
		         playedOn: 10
		         by: (OrderedCollection withAll: { 'sombrero'. 'bote' })
		         throwing: dice.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 10.
	self assert: (aGame currentPositionOfShip: 'bote') equals: 6
]

{ #category : 'tests' }
PharoGameTest >> test007WhenAGameHasNotStartedThenTheGameHasNoWinner [

	| aGame dice |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	aGame := PharoGame
		         playedOn: 10
		         by: (OrderedCollection withAll: { 'sombrero'. 'bote' })
		         throwing: dice.
	
	self deny: aGame hasWinner.
]

{ #category : 'tests' }
PharoGameTest >> test008WhenAGameIsFinishedThenTheGameKnowsTheWinner [

	| aGame dice |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	aGame := PharoGame
		         playedOn: 10
		         by: (OrderedCollection withAll: { 'sombrero'. 'bote' })
		         throwing: dice.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: aGame winner equals: 'sombrero'.
]

{ #category : 'tests' }
PharoGameTest >> test009WhenAGameHasNegativeSquaresThenItCanNotStart [

	| squares |
	squares := -10.
	self
		should: [ 	| aGame dice |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	aGame := PharoGame
		         playedOn: -10
		         by: (OrderedCollection withAll: { 'sombrero'. 'bote' })
		         throwing: dice. ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: PharoGame invalidSquaresErrorDescription ]
]

{ #category : 'tests' }
PharoGameTest >> test010WhenAGameHasNoSpaceShipThenItCanNotStart [

	| squares |
	squares := 10.
	self
		should: [
			| aGame dice |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	aGame := PharoGame
		         playedOn: 10
		         by: (OrderedCollection withAll: { })
		         throwing: dice.]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: PharoGame invalidShipsErrorDescription ]
]

{ #category : 'tests' }
PharoGameTest >> test011WhenGameUseADiceThenSpaceShipsMoveDiceRollResult [

	| aGame firstDie secondDie dice |
	firstDie := FixedDie withNumberOfFaces: 3.
	secondDie := FixedDie withNumberOfFaces: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	aGame := PharoGame
		         playedOn: 10
		         by:
		         (OrderedCollection withAll: { 'sombrero'. 'bote' })
		         throwing: dice.
	aGame playTurn.

	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 8
]

{ #category : 'tests' }
PharoGameTest >> test012WhenGameHasTwoSpaceShipsThenEachPlayerPlayATurn [

	| aGame squares firstDie secondDie dice |
	squares := 10.
	firstDie := FixedDie withNumberOfFaces: 3.
	secondDie := FixedDie withNumberOfFaces: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	aGame := PharoGame
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
PharoGameTest >> test013WhenDiceRollsIsBiggerThanSquaresThenShipFinalPositionIsMaxSquare [

	| aGame squares firstDie secondDie dice |
	
	squares := 10.
	firstDie := FixedDie withNumberOfFaces: 3.
	secondDie := FixedDie withNumberOfFaces: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	aGame := PharoGame playedOn: squares by: (OrderedCollection withAll: {'sombrero' . 'bote'.}) throwing: dice.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: aGame finished equals: true.
	self assert: aGame winner equals: 'sombrero'.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals:10
]

{ #category : 'tests' }
PharoGameTest >> test014WhenGameHasNotPlayedThenItHasNoWinner [

	| aGame dice |
	dice := Dice with: {
			        (FixedDie withNumberOfFaces: 3).
			        (FixedDie withNumberOfFaces: 3) }.
	aGame := PharoGame
		         playedOn: 10
		         by: (OrderedCollection withAll: { 'sombrero'. 'bote' })
		         throwing: dice.

	self
		should: [ aGame winner ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: 'The game has no winner yet' ]
]

{ #category : 'tests' }
PharoGameTest >> test015WhenGameIsFinishedThenFinishedReturnsTrue [

    | aGame dice |
    dice := Dice with: { FixedDie withNumberOfFaces: 5. FixedDie withNumberOfFaces: 5 }.
    aGame := PharoGame
        playedOn: 4
        by: (OrderedCollection withAll: {'sombrero'})
        throwing: dice.
    aGame playTurn.

    self assert: aGame finished.
]

{ #category : 'tests' }
PharoGameTest >> test016WhenGameIsFinishedThenStartedReturnsFalse [

    | aGame dice |
    dice := Dice with: { FixedDie withNumberOfFaces: 5. FixedDie withNumberOfFaces: 5 }.
    aGame := PharoGame
        playedOn: 10
        by: (OrderedCollection withAll: {'sombrero'})
        throwing: dice.
    aGame playTurn.

    self deny: aGame started.
]

{ #category : 'tests' }
PharoGameTest >> test017WhenGameIsFinishedThenItHasAWinner [

    | aGame dice |
    dice := Dice with: { FixedDie withNumberOfFaces: 5 }.
    aGame := PharoGame
        playedOn: 4
        by: (OrderedCollection withAll: {'sombrero'})
        throwing: dice.
    aGame playTurn.

    self assert: aGame hasWinner.
]
