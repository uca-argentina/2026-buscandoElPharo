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
		'cells',
		'dice',
		'winnerState',
		'turnManager'
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

{ #category : 'creation' }
PharoGame class >> playedOn: squares by: ships throwing: aDice [

	ships isEmpty ifTrue: [
		Error signal: self invalidShipsErrorDescription ].
	squares < 1 ifTrue: [
		Error signal: self invalidSquaresErrorDescription ].
	ships asSet size ~= ships size ifTrue: [
		Error signal: self duplicatedShipNamesErrorDescription ].

	^ self new
		  initializePharoGamePlayedOn: squares
		  by: ships
		  using: aDice
]

{ #category : 'accessing' }
PharoGame >> currentPositionOfShip: shipName [

	^ turnManager positionOf: shipName
]

{ #category : 'playing' }
PharoGame >> currentShip [

	^ turnManager currentShipIdentification 
]

{ #category : 'playing' }
PharoGame >> executeNextTurn [

	turnManager playTurnOn: self
]

{ #category : 'playing' }
PharoGame >> executeTurnFor: currentSpaceShip [

	currentSpaceShip advanceBy: (dice roll) top: cells.
	self verifyWinner: currentSpaceShip
]

{ #category : 'accessing - private' }
PharoGame >> finishGameWith: shipName [

	currentState := Finished new.
	winnerState := Winner withShip: shipName
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
PharoGame >> initializePharoGamePlayedOn: squares by: ships using: playableDice [

	| spaceShips |
	currentState := Started new.
	cells := squares.
	spaceShips := ships collect: [ :nombre |
		              SpaceShip namedAfter: nombre ].
	turnManager := TurnManager withShips: spaceShips.
	winnerState := NoWinner new.
	dice := playableDice
]

{ #category : 'actions' }
PharoGame >> playTurn [

	currentState playTurnOn: self.

]

{ #category : 'validation' }
PharoGame >> restartErrorDescription [

	^ 'Can not restart the game'
]

{ #category : 'accessing' }
PharoGame >> started [

	^ currentState started 
]

{ #category : 'accessing - private' }
PharoGame >> verifyWinner: spaceShip [

	spaceShip checkEndOn: self limitedTo: cells
]

{ #category : 'accessing' }
PharoGame >> winner [

	^ winnerState winner
]
