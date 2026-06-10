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
		'parsecsPerCell'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

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

{ #category : 'accessing' }
PharoGame >> allShips [

	^ shipManager allShips
]

{ #category : 'playing' }
PharoGame >> boardSize [

	^ board cells
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

{ #category : 'playing' }
PharoGame >> executeNextTurn [

	turnManager playTurnOn: self
]

{ #category : 'playing' }
PharoGame >> executeTurnFor: currentSpaceShip [

	| roll effect |

	roll := dice roll.
	currentSpaceShip
		advanceBy: roll
		top: board cells
		from: self.
	effect := board effectAtCell: currentSpaceShip position.
	effect
		applyTo: currentSpaceShip
		affecting: self allShips
		from: self
]

{ #category : 'accessing' }
PharoGame >> finished [

	^ currentState finished
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
	dice := playableDice
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
PharoGame >> restartErrorDescription [

	^ 'Can not restart the game'
]

{ #category : 'accessing' }
PharoGame >> started [

	^ currentState started 
]

{ #category : 'accessing' }
PharoGame >> winner [

	^ winnerState winner
]
