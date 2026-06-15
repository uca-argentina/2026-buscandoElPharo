Class {
	#name : 'CardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardTest >> test000WhenACardIsCreatedThenItIsNotInstant [

	| aCard |
	aCard := Card new.

	self deny: aCard isInstant
]

{ #category : 'tests' }
CardTest >> test001WhenACardIsCreatedThenItIsNotPermanent [

	| aCard |
	aCard := Card new.

	self deny: aCard isPermanent
]

{ #category : 'tests' }
CardTest >> test002WhenAnInstantCardIsCreatedThenItIsInstant [

	| aCard |

	aCard := InstantCard new.

	self assert: aCard isInstant
]

{ #category : 'tests' }
CardTest >> test003WhenAPermanentCardIsCreatedThenItIsPermanent [

	| aCard |

	aCard := PermanentCard new.

	self assert: aCard isPermanent
]

{ #category : 'tests' }
CardTest >> test004WhenAnInstantCardIsCreatedThenItIsNotPermanent [

	| aCard |

	aCard := InstantCard new.

	self deny: aCard isPermanent
]

{ #category : 'tests' }
CardTest >> test005WhenAPermanentCardIsCreatedThenItIsNotInstant [

	| aCard |

	aCard := PermanentCard new.

	self deny: aCard isInstant
]

{ #category : 'tests' }
CardTest >> test006WhenASpaceShipTriesToPlayACardThatItDoesNotHaveThenItRaisesAnError [

	| aCard aSpaceShip |
	aCard := InstantCard new.
	aSpaceShip := SpaceShip namedAfter: 'sombrero'.

	self
		should: [ aSpaceShip play: aCard ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: SpaceShip cardNotOwnedErrorDescription ]
]

{ #category : 'tests' }
CardTest >> test007WhenAPermanentCardIsPlayedThenItBecomesActiveInTheGame [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip aCard |

	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection withAll: { 'sombrero' }.

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

	self assert: (aGame hasActiveCard: aCard)
]

{ #category : 'tests' }
CardTest >> test008WhenAnInstantCardIsPlayedThenItDoesNotBecomeActiveInTheGame [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip aCard |

	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection withAll: { 'sombrero' }.

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
	aCard := InstantCard new.

	aSpaceShip addCard: aCard.

	aSpaceShip play: aCard in: aGame.

	self deny: (aGame hasActiveCard: aCard).
	self deny: (aSpaceShip hasCard: aCard)
]

{ #category : 'tests' }
CardTest >> test009WhenPermanentCardModifiesARollThenItDoesNotChangeIt [

	| aCard aSpaceShip |
	aCard := PermanentCard new.
	aSpaceShip := SpaceShip namedAfter: 'sombrero'.

	self assert: (aCard modifyRoll: 4 for: aSpaceShip) equals: 4
]

{ #category : 'tests' }
CardTest >> test010WhenSpeedCardIsCreatedThenItIsPermanent [

	| aCard |

	aCard := SpeedCard new.

	self assert: aCard isPermanent
]

{ #category : 'tests' }
CardTest >> test011WhenSpeedCardIsAppliedThenItAddsOneToARoll [

	| aCard |

	aCard := SpeedCard new.

	self assert: (aCard modifyRoll: 4) equals: 5
]

{ #category : 'tests' }
CardTest >> test012WhenOverloadCardIsCreatedThenItIsPermanent [

	| aCard |

	aCard := OverloadCard targeting: (SpaceShip namedAfter: 'sombrero').

	self assert: aCard isPermanent equals: true
]

{ #category : 'tests' }
CardTest >> test013WhenOverloadCardModifiesARollThenItReducesItByTwo [

	| targetSpaceShip aCard |
	targetSpaceShip := SpaceShip namedAfter: 'sombrero'.
	aCard := OverloadCard targeting: targetSpaceShip.

	self assert: (aCard modifyRoll: 4 for: targetSpaceShip) equals: 2
]

{ #category : 'tests' }
CardTest >> test014WhenOverloadCardModifiesAnotherSpaceShipRollThenItDoesNotAffectIt [

	| targetSpaceShip aCard otherShip |
	targetSpaceShip := SpaceShip namedAfter: 'sombrero'.
	otherShip := SpaceShip namedAfter: 'bote'.
	aCard := OverloadCard targeting: targetSpaceShip.

	self assert: (aCard modifyRoll: 4 for: otherShip) equals: 4
]

{ #category : 'tests' }
CardTest >> test015WhenAccelerationCardIsCreatedThenItIsPermanent [

	| aCard |
	aCard := AccelerationCard new.

	self assert: aCard isPermanent
]

{ #category : 'tests' }
CardTest >> test016WhenAccelerationCardModifiesARollThenItIncreasesItByOne [

	| aCard aSpaceShip |
	aSpaceShip := SpaceShip namedAfter: 'sombrero'.
	aCard := AccelerationCard new.

	self assert: (aCard modifyRoll: 4 for: aSpaceShip) equals: 5
]

{ #category : 'tests' }
CardTest >> test016WhenCancellationCardIsCreatedThenItIsInstant [

	| aCard |
	aCard := CancellationCard new.

	self assert: aCard isInstant
]

{ #category : 'tests' }
CardTest >> test017WhenCancellationCardCancelsAPermanentCardThenItIsRemovedFromActiveCards [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip aSpeedCard aCancellationCard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection withAll: { 'sombrero' }.

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
	aSpeedCard := SpeedCard targeting: aSpaceShip.
	aCancellationCard := CancellationCard new.

	aSpaceShip addCard: aSpeedCard.
	aSpaceShip play: aSpeedCard in: aGame.

	aCancellationCard cancel: aSpeedCard from: aGame.

	self deny: (aGame hasActiveCard: aSpeedCard)
]

{ #category : 'tests' }
CardTest >> test018WhenCancellationCardIsPlayedThenItCancelsTheSelectedPermanentCard [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip aSpeedCard aCancellationCard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection withAll: { 'sombrero' }.

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
	aSpeedCard := SpeedCard targeting: aSpaceShip.
	aCancellationCard := CancellationCard cancelling: aSpeedCard.

	aSpaceShip addCard: aSpeedCard.
	aSpaceShip addCard: aCancellationCard.

	aSpaceShip play: aSpeedCard in: aGame.
	aSpaceShip play: aCancellationCard in: aGame.

	self deny: (aGame hasActiveCard: aSpeedCard).
	self deny: (aSpaceShip hasCard: aCancellationCard).
	self assert: aGame amountOfActiveCards equals: 0
]

{ #category : 'tests' }
CardTest >> test019WhenCancellationCardTriesToCancelANonActivePermanentCardThenItRaisesAnError [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip aSpeedCard aCancellationCard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection withAll: { 'sombrero' }.

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
	aSpeedCard := SpeedCard targeting: aSpaceShip.
	aCancellationCard := CancellationCard cancelling: aSpeedCard.

	aSpaceShip addCard: aCancellationCard.

	self
		should: [ aSpaceShip play: aCancellationCard in: aGame ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: PharoGame cardIsNotActiveErrorDescription ]
]

{ #category : 'tests' }
CardTest >> test020WhenRepeatCardIsCreatedThenItIsInstant [

	| aCard |
	aCard := RepeatCard new.

	self assert: aCard isInstant
]

{ #category : 'tests' }
CardTest >> test021WhenAnEffectIsAppliedThenGameRemembersItAsLastAppliedEffect [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip anEffect |
	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection withAll: { 'sombrero' }.

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
	anEffect := WormHole new.

	anEffect applyTo: aSpaceShip affecting: aGame allShips from: aGame.

	self assert: aGame lastAppliedEffect equals: anEffect
]

{ #category : 'tests' }
CardTest >> test022WhenRepeatCardIsPlayedThenItRepeatsTheLastAppliedEffect [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip aCard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection withAll: { 'sombrero' }.

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
	aCard := RepeatCard new.

	aSpaceShip advanceBy: 8 top: aBoard cells from: aGame.
	aGame rememberAppliedEffect: WormHole new.

	aSpaceShip addCard: aCard.
	aSpaceShip play: aCard in: aGame.

	self assert: aSpaceShip position equals: 4
]

{ #category : 'tests' }
CardTest >> test023WhenRepeatCardIsPlayedWithoutPreviousEffectThenItRaisesAnError [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip aCard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection withAll: { 'sombrero' }.

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
	aCard := RepeatCard new.

	aSpaceShip addCard: aCard.

	self
		should: [ aSpaceShip play: aCard in: aGame ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: PharoGame noEffectToRepeatErrorDescription ]
]

{ #category : 'tests' }
CardTest >> test024WhenARedoCardIsCreatedThenItIsInstant [

	| aCard |

	aCard := RedoCard new.

	self assert: aCard isInstant
]

{ #category : 'tests' }
CardTest >> test025WhenACardIsPlayedThenGameRemembersItAsLastPlayedCard [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip aCard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection withAll: { 'sombrero' }.

	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution
		addHyperJump: 0
		withParsecs: (OrderedCollection withAll: { 1. 2. 3 }).
	distribution addMoonWalk: 0 movingBack: 2.
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

	self assert: aGame lastPlayedCard equals: aCard
]

{ #category : 'tests' }
CardTest >> test026WhenRedoCardIsPlayedThenItRepeatsTheLastPlayedCard [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip speedCard redoCard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection withAll: { 'sombrero' }.

	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0 withParsecs: (OrderedCollection with: 1).
	distribution addMoonWalk: 0 movingBack: 2.
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

	speedCard := SpeedCard targeting: aSpaceShip.
	redoCard := RedoCard new.

	aSpaceShip addCard: speedCard.
	aSpaceShip addCard: redoCard.

	aSpaceShip play: speedCard in: aGame.
	aSpaceShip play: redoCard in: aGame.

	self assert: aGame amountOfActiveCards equals: 2
]

{ #category : 'tests' }
CardTest >> test027WhenRedoCardIsPlayedWithoutPreviousCardThenItRaisesAnError [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip redoCard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection withAll: { 'sombrero' }.

	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0 withParsecs: (OrderedCollection with: 1).
	distribution addMoonWalk: 0 movingBack: 2.
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
	redoCard := RedoCard new.

	aSpaceShip addCard: redoCard.

	self
		should: [ aSpaceShip play: redoCard in: aGame ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: PharoGame noCardToRedoErrorDescription ]
]

{ #category : 'tests' }
CardTest >> test028WhenRedoCardIsPlayedThenGameKeepsPreviousCardAsLastPlayedCard [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip speedCard redoCard |
	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection withAll: { 'sombrero' }.

	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0 withParsecs: (OrderedCollection with: 1).
	distribution addMoonWalk: 0 movingBack: 2.
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
	speedCard := SpeedCard targeting: aSpaceShip.
	redoCard := RedoCard new.

	aSpaceShip addCard: speedCard.
	aSpaceShip addCard: redoCard.

	aSpaceShip play: speedCard in: aGame.
	aSpaceShip play: redoCard in: aGame.

	self assert: aGame lastPlayedCard equals: speedCard
]

{ #category : 'tests' }
CardTest >> test029WhenGameGivesCardToSpaceShipThenCardComesFromCardProvider [

	| aGame dice spaceShips distribution aBoard tiles aSpaceShip |
	dice := Dice with: { (FixedDie withNumberOfFaces: 1) }.
	spaceShips := OrderedCollection withAll: { 'sombrero' }.

	distribution := EffectDistribution generateForSize: 10.
	distribution addNoEffect: 1.
	distribution addSpeedUp: 0.
	distribution addWormHole: 0.
	distribution addHyperJump: 0 withParsecs: (OrderedCollection with: 1).
	distribution addMoonWalk: 0 movingBack: 2.
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

	aGame giveCardTo: aSpaceShip.

	self assert: aSpaceShip amountOfCards equals: 3
]

{ #category : 'tests' }
CardTest >> test030WhenLightYearsAreConvertedToParsecsThenThreeLightYearsEqualOneParsec [

	| distance |
	distance := LightYear distance: 3.

	self assert: distance asParsecs equals: 1
]
