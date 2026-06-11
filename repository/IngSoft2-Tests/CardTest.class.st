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
