"
Key collaborators:
- Dice: Provides the movement values.
- State (Started/Finished): Handles the game lifecycle.
"
Class {
	#name : 'PharoGame',
	#superclass : 'Object',
	#instVars : [
		'currentState',
		'dice',
		'winnerState',
		'turnManager',
		'board',
		'lapsToWin',
		'shipManager',
		'parsecsPerCell',
		'activeCards',
		'lastAppliedEffect',
		'lastPlayedCard',
		'cardProvider'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
PharoGame class >> cardIsNotActiveErrorDescription [

	^ 'Card is not active'
]

{ #category : 'validation' }
PharoGame class >> duplicatedShipNamesErrorDescription [

	^ 'PharoGame can not have SpaceShips with the same name'
]

{ #category : 'validation' }
PharoGame class >> invalidShipsErrorDescription [

	^ 'Can not start game with no players'
]

{ #category : 'validation' }
PharoGame class >> invalidSquaresErrorDescription [

	^ 'Can not start game with less than 1 square'
]

{ #category : 'validation' }
PharoGame class >> negativeLapErrorDescription [

	^ 'Laps can not be negative'
]

{ #category : 'validation' }
PharoGame class >> noCardToRedoErrorDescription [

	^ 'There is no card to redo'
]

{ #category : 'validation' }
PharoGame class >> noEffectToRepeatErrorDescription [

	^ 'There is no effect to repeat'
]

{ #category : 'creation' }
PharoGame class >> playedOn: aBoard by: ships throwing: aDice laps: laps [

	ships isEmpty ifTrue: [
		Error signal: self invalidShipsErrorDescription ].
	ships asSet size ~= ships size ifTrue: [
		Error signal: self duplicatedShipNamesErrorDescription ].

	laps < 0 ifTrue: [ Error signal: self negativeLapErrorDescription ].
	^ self new
		  initializePharoGamePlayedOn: aBoard
		  by: ships
		  using: aDice
		  laps: laps
]

{ #category : 'as yet unclassified' }
PharoGame >> activateCard: aCard [

	activeCards add: aCard
]

{ #category : 'accessing' }
PharoGame >> allShips [

	^ shipManager allShips
]

{ #category : 'as yet unclassified' }
PharoGame >> amountOfActiveCards [

	^ activeCards size
]

{ #category : 'playing' }
PharoGame >> boardSize [

	^ board cells
]

{ #category : 'accessing' }
PharoGame >> cardProvider: aCardProvider [

	cardProvider := aCardProvider
]

{ #category : 'as yet unclassified' }
PharoGame >> cellsRepresenting: aParsec [

	^ board cellsRepresenting: aParsec 
]

{ #category : 'playing' }
PharoGame >> checkWinnerFor: aSpaceShip with: laps [

	laps = lapsToWin ifFalse: [ ^ self ].
	currentState := Finished new.
	winnerState := Winner withShip: aSpaceShip
]

{ #category : 'accessing' }
PharoGame >> currentLapOfShip: shipName [

	^ shipManager lapOf: shipName
]

{ #category : 'accessing' }
PharoGame >> currentPositionOfShip: shipName [

	^ shipManager positionOf: shipName
]

{ #category : 'playing' }
PharoGame >> currentShip [

	^ shipManager currentShipIdentification: turnManager currentTurn 
]

{ #category : 'as yet unclassified' }
PharoGame >> deactivateCard: aCard [

	(self hasActiveCard: aCard) ifFalse: [
		Error signal: self class cardIsNotActiveErrorDescription ].

	activeCards remove: aCard
]

{ #category : 'as yet unclassified' }
PharoGame >> dealInitialCards [

	self allShips do: [ :aShip |
		aShip addCard: InstantCard new.
		aShip addCard: PermanentCard new ]
]

{ #category : 'playing' }
PharoGame >> executeNextTurn [

	turnManager playTurnOn: self
]

{ #category : 'playing' }
PharoGame >> executeTurnFor: currentSpaceShip [

	| roll effect |
	roll := self rollFor: currentSpaceShip.
	currentSpaceShip advanceBy: roll top: board cells from: self.
	effect := board effectAtCell: currentSpaceShip position.
	effect applyTo: currentSpaceShip affecting: self allShips from: self
]

{ #category : 'accessing' }
PharoGame >> finished [

	^ currentState finished
]

{ #category : 'as yet unclassified' }
PharoGame >> giveCardTo: aSpaceShip [

	aSpaceShip addCard: cardProvider nextCard
]

{ #category : 'testing' }
PharoGame >> hasActiveCard: aCard [

	^ activeCards includes: aCard
]

{ #category : 'testing' }
PharoGame >> hasWinner [

	^ winnerState hasWon.
]

{ #category : 'initialization' }
PharoGame >> initializePharoGamePlayedOn: aBoard by: ships using: playableDice laps: laps [

	| spaceShips |
	currentState := Started new.
	board := aBoard.
	lapsToWin := laps.
	spaceShips := ships collect: [ :nombre |
		              SpaceShip namedAfter: nombre ].

	shipManager := SpaceShipsManager withShips: spaceShips.
	turnManager := TurnManager madeOf: spaceShips.
	winnerState := NoWinner new.
	dice := playableDice.
	activeCards := OrderedCollection new.
	cardProvider := CardProvider withCards: (OrderedCollection
			                 with: SpeedCard new
			                 with: OverloadCard new
			                 with: AccelerationCard new
			                 with: CancellationCard new
			                 with: RepeatCard new
			                 with: RedoCard new).

	self dealInitialCards
]

{ #category : 'accessing' }
PharoGame >> lastAppliedEffect [

	^ lastAppliedEffect
]

{ #category : 'accessing' }
PharoGame >> lastPlayedCard [

	^ lastPlayedCard
]

{ #category : 'playing' }
PharoGame >> playTurn [

	currentState playTurnOn: self.

]

{ #category : 'playing' }
PharoGame >> rankOf: aSpaceShip [

	^ shipManager rankOfThis: aSpaceShip
]

{ #category : 'validation' }
PharoGame >> redoLastPlayedCardFor: aSpaceShip [

	lastPlayedCard ifNil: [
		Error signal: self class noCardToRedoErrorDescription ].

	lastPlayedCard replayedBy: aSpaceShip in: self
]

{ #category : 'validation' }
PharoGame >> rememberAppliedEffect: anEffect [

	lastAppliedEffect := anEffect
]

{ #category : 'validation' }
PharoGame >> rememberPlayedCard: aCard [

	lastPlayedCard := aCard
]

{ #category : 'removing' }
PharoGame >> removeActiveCard: aCard [

	activeCards remove: aCard
]

{ #category : 'validation' }
PharoGame >> repeatLastAppliedEffectOn: aSpaceShip [

	lastAppliedEffect ifNil: [
		Error signal: self class noEffectToRepeatErrorDescription ].

	lastAppliedEffect
		applyTo: aSpaceShip
		affecting: self allShips
		from: self
]

{ #category : 'validation' }
PharoGame >> restartErrorDescription [

	^ 'Can not restart the game'
]

{ #category : 'as yet unclassified' }
PharoGame >> rollFor: aSpaceShip [

	^ activeCards
		  inject: dice roll
		  into: [ :currentRoll :aCard |
		  aCard modifyRoll: currentRoll for: aSpaceShip ]
]

{ #category : 'accessing' }
PharoGame >> started [

	^ currentState started 
]

{ #category : 'accessing' }
PharoGame >> winner [

	^ winnerState winner
]
