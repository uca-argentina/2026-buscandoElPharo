Class {
	#name : 'PharoGameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PharoGameTest >> test001WhenAGameIsCreatedThenAGameIsStarted [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection with: 'sombrero'.

	distribution := EffectDistribution generateForSize: 100.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.
		aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 1.

	self assert: aGame started equals: true
]

{ #category : 'tests' }
PharoGameTest >> test002WhenAGameHasAlreadyBeenFinishedThenSimulationCanNotReplay [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 11) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 1.
	aGame playTurn.

	self
		should: [ aGame playTurn ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: aGame restartErrorDescription ]
]

{ #category : 'tests' }
PharoGameTest >> test003WhenAGameHasCompletedSequenceOfSquaresThenGameIsFinished [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 11) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame
		         playedOn: aBoard
		         by: spaceShips
		         throwing: dice
		         laps: 1.
	aGame playTurn.
	self assert: aGame finished equals: true
]

{ #category : 'tests' }
PharoGameTest >> test004WhenAGameHasAThrowLargerThanSquaresThenGameCanKeepPlayingUntilFinished [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 1.
	aGame playTurn.
	self assert: aGame finished equals: false
]

{ #category : 'tests' }
PharoGameTest >> test005WhenAGamePlayATurnThenGameKnowsSpaceShipsPosition [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 1.
	aGame playTurn.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 6
]

{ #category : 'tests' }
PharoGameTest >> test006WhenAGameHasMoreThanOneSpaceShipThenGameCanPlayTurnUntilFinished [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 11) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 1.
	aGame playTurn.

	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 1.
	self assert: (aGame currentPositionOfShip: 'bote') equals: 0
]

{ #category : 'tests' }
PharoGameTest >> test007WhenAGameHasNotStartedThenTheGameHasNoWinner [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 1.

	self deny: aGame hasWinner
]

{ #category : 'tests' }
PharoGameTest >> test008WhenAGameIsFinishedThenTheGameKnowsTheWinner [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 11) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 1.
	aGame playTurn.

	self assert: aGame winner equals: 'sombrero'
]

{ #category : 'tests' }
PharoGameTest >> test009WhenAGameHasNoSpaceShipThenItCanNotStart [

| dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := ''.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.

	self
		should: [ PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 1. ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: PharoGame invalidShipsErrorDescription ]
]

{ #category : 'tests' }
PharoGameTest >> test010WhenAGameUseADiceThenSpaceShipsMoveDiceRollResult [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 1.
	aGame playTurn.

	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 6
]

{ #category : 'tests' }
PharoGameTest >> test011WhenDiceRollsIsLargerThanSquaresThenShipFinalPositionIsMaxSquare [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 12) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 1.
	aGame playTurn.
	self assert: aGame winner equals: 'sombrero'.
	self assert: (aGame currentPositionOfShip: 'sombrero') equals: 2
]

{ #category : 'tests' }
PharoGameTest >> test012WhenAGameHasNotPlayedThenItHasNoWinner [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 1.

	self
		should: [ aGame winner ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: (NoWinner new) noWinnerErrorDescription ]
]

{ #category : 'tests' }
PharoGameTest >> test013WhenAGameIsFinishedThenCurrentStateIsFinished [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 12) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 1.
	aGame playTurn.

	self assert: aGame finished
]

{ #category : 'tests' }
PharoGameTest >> test014WhenAGameIsFinishedThenItHasAWinner [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	distribution := EffectDistribution generateForSize: 5.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 1.
	aGame playTurn.

	self assert: aGame hasWinner
]

{ #category : 'tests' }
PharoGameTest >> test015WhenTwoSpaceShipsAreBeingCreatedThenTheyCannotHaveTheSameName [

	| dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'sombrero' }.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.

	self
		should: [ PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 1]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: PharoGame duplicatedShipNamesErrorDescription ]
]

{ #category : 'tests' }
PharoGameTest >> test016 [
"cambiar num por 16"

	| aGame dice spaceShips distribution tiles aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection with: 'sombrero' with: 'bote'.
	distribution := EffectDistribution generateForSize: 5.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.
	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame
		         playedOn: aBoard
		         by: spaceShips
		         throwing: dice
		         laps: 2.
	aGame playTurn.
	self assert: aGame currentShip equals: 'bote'
]

{ #category : 'tests' }
PharoGameTest >> test017WhenASpaceShipCompletesRequiredLapsThenItIsTheWinner [

	| aGame dice spaceShips distribution tiles aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection with: 'sombrero' with: 'bote'.
	distribution := EffectDistribution generateForSize: 5.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.
	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame
		         playedOn: aBoard
		         by: spaceShips
		         throwing: dice
		         laps: 2.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: aGame winner equals: 'sombrero'
]

{ #category : 'tests' }
PharoGameTest >> test018WhenASpaceShipCompletesALapThenItIsSecondLap [

	| aGame dice spaceShips distribution tiles aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	distribution := EffectDistribution generateForSize: 5.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.
	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame playedOn: aBoard by: spaceShips throwing: dice laps: 3.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame currentLapOfShip: 'sombrero') equals: 2.
]

{ #category : 'tests' }
PharoGameTest >> test019WhenAGameAreBeingCreatedThenALapCannotBeNegative [

	| dice spaceShips distribution tiles aBoard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection with: 'sombrero'.
	distribution := EffectDistribution generateForSize: 5.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.
	tiles := distribution build.
	aBoard := Board withCells: tiles.
	self
		should: [
			PharoGame
				playedOn: aBoard
				by: spaceShips
				throwing: dice
				laps: -1 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: PharoGame negativeLapErrorDescription ]
]

{ #category : 'tests' }
PharoGameTest >> test020WhenTwoSpaceShipsPlayThenRankingShowsWhoIsAhead [

	| aGame dice aBoard tiles distribution ships |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.
	tiles := distribution build.
	aBoard := Board withCells: tiles.
	ships := OrderedCollection with: 'sombrero' with: 'bote'.
	aGame := PharoGame
		         playedOn: aBoard
		         by: ships
		         throwing: dice
		         laps: 2.

	aGame playTurn.

	self assert: (aGame rankOf: 'sombrero') equals: 1.
	self assert: (aGame rankOf: 'bote') equals: 2
]

{ #category : 'tests' }
PharoGameTest >> test021WhenAShipHasMoreLapsThenItRanksHigherRegardlessOfPosition [

    | aGame dice aBoard tiles distribution |
    dice := Dice with: { FixedDie withNumberOfFaces: 6 }.
    distribution := EffectDistribution generateForSize: 5.
    distribution addNoEffect: 1.
    distribution addSpeedUp: 0.
    distribution addWormHole: 0.
    distribution addHyperJump: 0.
    distribution addMoonWalk: 0.
    distribution addAtomicBomb: 0.
    tiles := distribution build.
    aBoard := Board withCells: tiles.
    aGame := PharoGame playedOn: aBoard by: #('sombrero' 'bote') throwing: dice laps: 3.

    aGame playTurn.
    aGame playTurn.
    aGame playTurn.

    self assert: (aGame rankOf: 'sombrero') equals: 1.
    self assert: (aGame rankOf: 'bote') equals: 2.
]

{ #category : 'tests' }
PharoGameTest >> test022WhenSpaceShipsAreInSameLapThenRankingOrdersByPosition [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 6) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.
	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.
	tiles := distribution build.
	aBoard := Board withCells: tiles.
	aGame := PharoGame
		         playedOn: aBoard
		         by: spaceShips
		         throwing: dice
		         laps: 2.
	aGame playTurn.
	self assert: (aGame rankOf: 'sombrero') equals: 1.
	self assert: (aGame rankOf: 'bote') equals: 2
]

{ #category : 'tests' }
PharoGameTest >> test023WhenGameIsCreatedThenEachSpaceShipStartsWithTwoCards [

	| aGame dice spaceShips distribution aBoard tiles |
	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.

	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.

	aGame := PharoGame
		         playedOn: aBoard
		         by: spaceShips
		         throwing: dice
		         laps: 2.

	self assert: (aGame allShips first amountOfCards) equals: 2.
	self assert: (aGame allShips second amountOfCards) equals: 2.
]

{ #category : 'tests' }
PharoGameTest >> test024WhenGameGivesACardToASpaceShipThenThatSpaceShipHasOneMoreCard [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip |

	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection withAll: { 'sombrero' }.

	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.

	aGame := PharoGame
		playedOn: aBoard
		by: spaceShips
		throwing: dice
		laps: 2.

	aSpaceShip := aGame allShips first.

	aGame giveCardTo: aSpaceShip.

	self assert: aSpaceShip amountOfCards equals: 3
]

{ #category : 'tests' }
PharoGameTest >> test025WhenAPermanentCardIsActivatedThenGameKnowsItHasOneActiveCard [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip aCard |

	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection with: 'sombrero'.

	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.
	distribution addCardGiver: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.

	aGame := PharoGame
		playedOn: aBoard
		by: spaceShips
		throwing: dice
		laps: 2.

	aSpaceShip := aGame allShips first.
	aCard := PermanentCard new.

	aSpaceShip addCard: aCard.
	aSpaceShip play: aCard in: aGame.

	self assert: aGame amountOfActiveCards equals: 1
]

{ #category : 'tests' }
PharoGameTest >> test026WhenSpeedCardIsActiveThenSpaceShipRollIsIncreasedByOne [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip aCard |

	dice := Dice with: { (FixedDie withNumberOfFaces: 4) }.
	spaceShips := OrderedCollection with: 'sombrero'.

	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.
	distribution addCardGiver: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.

	aGame := PharoGame
		playedOn: aBoard
		by: spaceShips
		throwing: dice
		laps: 2.

	aSpaceShip := aGame allShips first.
	aCard := SpeedCard targeting: aSpaceShip.

	aSpaceShip addCard: aCard.
	aSpaceShip play: aCard in: aGame.
	
	self assert: aGame amountOfActiveCards equals: 1.

	aGame playTurn.

	self assert: aSpaceShip position equals: 5
]

{ #category : 'tests' }
PharoGameTest >> test027WhenSpeedCardTargetsOneSpaceShipThenOnlyThatSpaceShipRollIsIncreased [

	| aGame dice spaceShips distribution aBoard tiles firstShip secondShip aCard |

	dice := Dice with: { (FixedDie withNumberOfFaces: 4) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.

	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.
	distribution addCardGiver: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.

	aGame := PharoGame
		playedOn: aBoard
		by: spaceShips
		throwing: dice
		laps: 2.

	firstShip := aGame allShips first.
	secondShip := aGame allShips second.

	aCard := SpeedCard targeting: firstShip.

	firstShip addCard: aCard.
	firstShip play: aCard in: aGame.

	aGame playTurn.
	aGame playTurn.

	self assert: firstShip position equals: 5.
	self assert: secondShip position equals: 4
]

{ #category : 'tests' }
PharoGameTest >> test028WhenSpeedCardTargetsOneSpaceShipThenItDoesNotModifyAnotherSpaceShipRoll [

	| aGame dice spaceShips distribution aBoard tiles firstShip secondShip aCard |

	dice := Dice with: { (FixedDie withNumberOfFaces: 4) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.

	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.
	distribution addCardGiver: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.

	aGame := PharoGame
		playedOn: aBoard
		by: spaceShips
		throwing: dice
		laps: 2.

	firstShip := aGame allShips first.
	secondShip := aGame allShips second.

	aCard := SpeedCard targeting: firstShip.

	firstShip addCard: aCard.
	firstShip play: aCard in: aGame.

	aGame playTurn.
	aGame playTurn.

	self assert: firstShip position equals: 5.
	self assert: secondShip position equals: 4
]

{ #category : 'tests' }
PharoGameTest >> test029WhenOverloadCardIsActiveThenTargetSpaceShipRollIsReducedByTwo [

	| dice spaceShips distribution tiles aBoard aGame aSpaceShip aCard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 4) }.
	spaceShips := OrderedCollection with: 'sombrero'.

	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.
	distribution addCardGiver: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.

	aGame := PharoGame
		         playedOn: aBoard
		         by: spaceShips
		         throwing: dice
		         laps: 2.

	aSpaceShip := aGame allShips first.
	aCard := OverloadCard targeting: aSpaceShip.

	aSpaceShip addCard: aCard.
	aSpaceShip play: aCard in: aGame.

	aGame playTurn.

	self assert: aSpaceShip position equals: 2
]

{ #category : 'tests' }
PharoGameTest >> test030WhenAccelerationCardIsActiveThenAllSpaceShipsIncreaseTheirRollByOne [

	| aGame dice spaceShips distribution aBoard tiles firstSpaceShip secondSpaceShip aCard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 4) }.
	spaceShips := OrderedCollection withAll: { 'sombrero'. 'bote' }.

	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0.
	distribution addMoonWalk: 0.
	distribution addAtomicBomb: 0.
	distribution addCardGiver: 0.

	tiles := distribution build.
	aBoard := Board withCells: tiles.

	aGame := PharoGame
		         playedOn: aBoard
		         by: spaceShips
		         throwing: dice
		         laps: 2.

	firstSpaceShip := aGame allShips first.
	secondSpaceShip := aGame allShips second.

	aCard := AccelerationCard new.
	firstSpaceShip addCard: aCard.
	firstSpaceShip play: aCard in: aGame.

	aGame playTurn.
	aGame playTurn.

	self assert: firstSpaceShip position equals: 5.
	self assert: secondSpaceShip position equals: 5
]
