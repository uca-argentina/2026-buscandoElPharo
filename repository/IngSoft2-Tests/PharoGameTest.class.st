Class {
	#name : 'PharoGameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PharoGameTest >> test001WhenAGameIsCreatedThenASimulationCanStart [

	| aGame dice spaceShips |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	aGame := PharoGame playedOn: 4 by: spaceShips throwing: dice.

	self assert: aGame started equals: true
]

{ #category : 'tests' }
PharoGameTest >> test002WhenAGameHasAlreadyBeenFinishedThenSimulationCanNotReplay [
	
	| aGame dice spaceShips |
	dice := Dice with: { (FixedDie withNumberOfFaces: 3) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	aGame := PharoGame playedOn: 6 by: spaceShips throwing: dice.
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
	
	| aGame dice spaceShips |
	dice := Dice with: { (FixedDie withNumberOfFaces: 3) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	aGame := PharoGame playedOn: 5 by: spaceShips throwing: dice.
	aGame playTurn.
	aGame playTurn.
	self assert: aGame finished equals: true
]

{ #category : 'tests' }
PharoGameTest >> test004WhenAGameHasAThrowLargerThanSquaresThenGameKeepsPlayingUntilFinished [

	| aGame dice spaceShips |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	aGame := PharoGame playedOn: 4 by: spaceShips throwing: dice.
	aGame playTurn.
	self assert: aGame finished equals: true.
]

{ #category : 'tests' }
PharoGameTest >> test005WhenGamePlayATurnThenGameKnowsSpaceShipsPosition [

	| aGame dice spaceShips |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	aGame := PharoGame playedOn: 10 by: spaceShips throwing: dice.
	aGame playTurn.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 7
]

{ #category : 'tests' }
PharoGameTest >> test006WhenAGameHasMoreThanOneSpaceShipThenGameCanPlayTurnUntilFinished [

	| aGame dice spaceShips |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	aGame := PharoGame playedOn: 10 by: spaceShips throwing: dice.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 10.
	self assert: (aGame currentPositionOfShip: 'bote') equals: 7
]

{ #category : 'tests' }
PharoGameTest >> test007WhenAGameHasNotStartedThenTheGameHasNoWinner [

	| aGame dice spaceShips |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	aGame := PharoGame playedOn: 10 by: spaceShips throwing: dice.

	self deny: aGame hasWinner
]

{ #category : 'tests' }
PharoGameTest >> test008WhenAGameIsFinishedThenTheGameKnowsTheWinner [

	| aGame dice spaceShips |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	aGame := PharoGame playedOn: 10 by: spaceShips throwing: dice.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: aGame winner equals: 'sombrero'
]

{ #category : 'tests' }
PharoGameTest >> test009WhenAGameHasNegativeSquaresThenItCanNotStart [

	| dice spaceShips squares |
	squares := -10.
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	self
		should: [ PharoGame playedOn: squares by: spaceShips throwing: dice ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: PharoGame invalidSquaresErrorDescription ]
]

{ #category : 'tests' }
PharoGameTest >> test010WhenAGameHasNoSpaceShipThenItCanNotStart [

	| dice spaceShips |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := ''.

	self
		should: [ PharoGame playedOn: 10 by: spaceShips throwing: dice ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: PharoGame invalidShipsErrorDescription ]
]

{ #category : 'tests' }
PharoGameTest >> test011WhenGameUseADiceThenSpaceShipsMoveDiceRollResult [

	| aGame firstDie secondDie dice spaceShips |
	firstDie := FixedDie withNumberOfFaces: 3.
	secondDie := FixedDie withNumberOfFaces: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	aGame := PharoGame playedOn: 10 by: spaceShips throwing: dice.
	aGame playTurn.

	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 9
]

{ #category : 'tests' }
PharoGameTest >> test013WhenDiceRollsIsBiggerThanSquaresThenShipFinalPositionIsMaxSquare [

	| aGame firstDie secondDie dice spaceShips |
	firstDie := FixedDie withNumberOfFaces: 3.
	secondDie := FixedDie withNumberOfFaces: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	aGame := PharoGame playedOn: 10 by: spaceShips throwing: dice.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: aGame winner equals: 'sombrero'.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 10
]

{ #category : 'tests' }
PharoGameTest >> test014WhenGameHasNotPlayedThenItHasNoWinner [

	| aGame firstDie secondDie dice spaceShips |
	firstDie := FixedDie withNumberOfFaces: 3.
	secondDie := FixedDie withNumberOfFaces: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	aGame := PharoGame playedOn: 10 by: spaceShips throwing: dice.

	self
		should: [ aGame winner ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: 'The game has no winner yet' ]
]

{ #category : 'tests' }
PharoGameTest >> test015WhenGameIsFinishedThenFinishedReturnsTrue [

	| aGame firstDie secondDie dice spaceShips |
	firstDie := FixedDie withNumberOfFaces: 3.
	secondDie := FixedDie withNumberOfFaces: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	aGame := PharoGame playedOn: 7 by: spaceShips throwing: dice.
	aGame playTurn.

	self assert: aGame finished
]

{ #category : 'tests' }
PharoGameTest >> test016WhenGameIsFinishedThenStartedReturnsFalse [

	| aGame firstDie secondDie dice spaceShips |
	firstDie := FixedDie withNumberOfFaces: 3.
	secondDie := FixedDie withNumberOfFaces: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	aGame := PharoGame playedOn: 8 by: spaceShips throwing: dice.
	aGame playTurn.

	self deny: aGame started
]

{ #category : 'tests' }
PharoGameTest >> test017WhenGameIsFinishedThenItHasAWinner [

	| aGame firstDie secondDie dice spaceShips |
	firstDie := FixedDie withNumberOfFaces: 3.
	secondDie := FixedDie withNumberOfFaces: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	aGame := PharoGame playedOn: 4 by: spaceShips throwing: dice.
	aGame playTurn.

	self assert: aGame hasWinner
]

{ #category : 'tests' }
PharoGameTest >> test018WhenTwoSpaceShipsAreBeingCreatedThenTheyCannotHaveTheSameName [

	| aGame firstDie secondDie dice spaceShips |
	firstDie := FixedDie withNumberOfFaces: 3.
	secondDie := FixedDie withNumberOfFaces: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'sombrero' }.

	self
		should: [ aGame := PharoGame playedOn: 10 by: spaceShips throwing: dice ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: PharoGame duplicatedShipNamesErrorDescription ]
]
