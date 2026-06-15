Class {
	#name : 'CardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardTest >> test001WhenAnInstantCardIsCreatedThenItIsInstant [

	| aCard |

	aCard := InstantCard new.

	self assert: aCard isInstant
]

{ #category : 'tests' }
CardTest >> test002WhenAPermanentCardIsCreatedThenItIsPermanent [

	| aCard |

	aCard := PermanentCard new.

	self assert: aCard isPermanent
]

{ #category : 'tests' }
CardTest >> test003WhenAnInstantCardIsCreatedThenItIsNotPermanent [

	| aCard |

	aCard := InstantCard new.

	self deny: aCard isPermanent
]

{ #category : 'tests' }
CardTest >> test004WhenAPermanentCardIsCreatedThenItIsNotInstant [

	| aCard |

	aCard := PermanentCard new.

	self deny: aCard isInstant
]

{ #category : 'tests' }
CardTest >> test005WhenASpaceShipTriesToPlayACardThatItDoesNotHaveThenItRaisesAnError [

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
CardTest >> test006WhenAPermanentCardIsPlayedThenItBecomesActiveInTheGame [

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
CardTest >> test007WhenAnInstantCardIsPlayedThenItDoesNotBecomeActiveInTheGame [

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
CardTest >> test008WhenSpeedCardIsCreatedThenItIsPermanent [

	| aCard |

	aCard := SpeedCard new.

	self assert: aCard isPermanent
]

{ #category : 'tests' }
CardTest >> test009WhenSpeedCardIsAppliedThenItAddsOneToARoll [

	| aCard |

	aCard := SpeedCard new.

	self assert: (aCard modifyRoll: 4) equals: 5
]

{ #category : 'tests' }
CardTest >> test010WhenOverloadCardIsCreatedThenItIsPermanent [

	| aCard |

	aCard := OverloadCard targeting: (SpaceShip namedAfter: 'sombrero').

	self assert: aCard isPermanent equals: true
]

{ #category : 'tests' }
CardTest >> test011WhenOverloadCardModifiesARollThenItReducesItByTwo [

	| targetSpaceShip aCard |
	targetSpaceShip := SpaceShip namedAfter: 'sombrero'.
	aCard := OverloadCard targeting: targetSpaceShip.

	self assert: (aCard modifyRoll: 4 for: targetSpaceShip) equals: 2
]

{ #category : 'tests' }
CardTest >> test012WhenOverloadCardModifiesAnotherSpaceShipRollThenItDoesNotAffectIt [

	| targetSpaceShip aCard otherShip |
	targetSpaceShip := SpaceShip namedAfter: 'sombrero'.
	otherShip := SpaceShip namedAfter: 'bote'.
	aCard := OverloadCard targeting: targetSpaceShip.

	self assert: (aCard modifyRoll: 4 for: otherShip) equals: 4
]

{ #category : 'tests' }
CardTest >> test013WhenAccelerationCardIsCreatedThenItIsPermanent [

	| aCard |
	aCard := AccelerationCard new.

	self assert: aCard isPermanent
]

{ #category : 'tests' }
CardTest >> test014WhenAccelerationCardModifiesARollThenItIncreasesItByOne [

	| aCard aSpaceShip |
	aSpaceShip := SpaceShip namedAfter: 'sombrero'.
	aCard := AccelerationCard new.

	self assert: (aCard modifyRoll: 4 for: aSpaceShip) equals: 5
]

{ #category : 'tests' }
CardTest >> test015WhenCancellationCardIsCreatedThenItIsInstant [

	| aCard |
	aCard := CancellationCard new.

	self assert: aCard isInstant
]

{ #category : 'tests' }
CardTest >> test016WhenCancellationCardCancelsAPermanentCardThenItIsRemovedFromActiveCards [

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
CardTest >> test017WhenCancellationCardIsPlayedThenItCancelsTheSelectedPermanentCard [

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
CardTest >> test018WhenCancellationCardTriesToCancelANonActivePermanentCardThenItRaisesAnError [

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
