Class {
	#name : 'PharoGameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PharoGameTest >> test001WhenAGameIsCreatedThenAGameIsStarted [

	| aGame dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 4.
	aBoard := Board withCells: generatedCells.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.

	self assert: aGame started equals: true
]

{ #category : 'tests' }
PharoGameTest >> test002WhenAGameHasAlreadyBeenFinishedThenSimulationCanNotReplay [
	
	| aGame dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 10.
	aBoard := Board withCells: generatedCells.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.
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
	
	| aGame dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 10.
	aBoard := Board withCells: generatedCells.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.
	aGame playTurn.
	aGame playTurn.
	self assert: aGame finished equals: true
]

{ #category : 'tests' }
PharoGameTest >> test004WhenAGameHasAThrowLargerThanSquaresThenGameCanKeepPlayingUntilFinished [

	| aGame dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 100.
	aBoard := Board withCells: generatedCells.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.
	aGame playTurn.
	self assert: aGame finished equals: false.
]

{ #category : 'tests' }
PharoGameTest >> test005WhenAGamePlayATurnThenGameKnowsSpaceShipsPosition [

	| aGame dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 10.
	aBoard := Board withCells: generatedCells.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.
	aGame playTurn.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 7
]

{ #category : 'tests' }
PharoGameTest >> test006WhenAGameHasMoreThanOneSpaceShipThenGameCanPlayTurnUntilFinished [

	| aGame dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 10.
	aBoard := Board withCells: generatedCells.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 10.
	self assert: (aGame currentPositionOfShip: 'bote') equals: 7
]

{ #category : 'tests' }
PharoGameTest >> test007WhenAGameHasNotStartedThenTheGameHasNoWinner [

	| aGame dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 5.
	aBoard := Board withCells: generatedCells.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.

	self deny: aGame hasWinner
]

{ #category : 'tests' }
PharoGameTest >> test008WhenAGameIsFinishedThenTheGameKnowsTheWinner [

	| aGame dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 10.
	aBoard := Board withCells: generatedCells.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: aGame winner equals: 'sombrero'
]

{ #category : 'tests' }
PharoGameTest >> test009WhenAGameHasNoSpaceShipThenItCanNotStart [

| dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := ''.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 10.
	aBoard := Board withCells: generatedCells.

	self
		should: [ PharoGame playedOn: aBoard by: spaceShips throwing: dice. ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: PharoGame invalidShipsErrorDescription ]
]

{ #category : 'tests' }
PharoGameTest >> test010WhenAGameUseADiceThenSpaceShipsMoveDiceRollResult [

	| aGame dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 10.
	aBoard := Board withCells: generatedCells.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.
	aGame playTurn.

	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 7
]

{ #category : 'tests' }
PharoGameTest >> test011WhenDiceRollsIsLargerThanSquaresThenShipFinalPositionIsMaxSquare [

	| aGame dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 12) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 10.
	aBoard := Board withCells: generatedCells.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.
	aGame playTurn.

	self assert: aGame winner equals: 'sombrero'.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 10
]

{ #category : 'tests' }
PharoGameTest >> test012WhenAGameHasNotPlayedThenItHasNoWinner [

	| aGame dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 10.
	aBoard := Board withCells: generatedCells.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.

	self
		should: [ aGame winner ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: (NoWinner new) noWinnerErrorDescription ]
]

{ #category : 'tests' }
PharoGameTest >> test013WhenAGameIsFinishedThenCurrentStateIsFinished [

	| aGame dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 12) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 10.
	aBoard := Board withCells: generatedCells.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.
	aGame playTurn.

	self assert: aGame finished
]

{ #category : 'tests' }
PharoGameTest >> test014WhenAGameIsFinishedThenItHasAWinner [

	| aGame dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 4.
	aBoard := Board withCells: generatedCells.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice.
	aGame playTurn.

	self assert: aGame hasWinner
]

{ #category : 'tests' }
PharoGameTest >> test015WhenTwoSpaceShipsAreBeingCreatedThenTheyCannotHaveTheSameName [

	| dice spaceShips probabilities distribution generatedCells aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'sombrero' }.
	probabilities := Dictionary new.
	probabilities at: NoEffect put: 1.

	distribution := EffectDistribution withProbabilities: probabilities.
	generatedCells := distribution generateCells: 10.
	aBoard := Board withCells: generatedCells.

	self
		should: [ PharoGame playedOn: aBoard by: spaceShips throwing: dice ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: PharoGame duplicatedShipNamesErrorDescription ]
]
