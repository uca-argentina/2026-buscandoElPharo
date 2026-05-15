"
Key collaborators:
- Dice: Provides the movement values.
- State (Started/Finished): Handles the game lifecycle.
- ships: A Dictionary for positions.
- turnOrder: An OrderedCollection to ensure deterministic turns.
"
Class {
	#name : 'PharoGame',
	#superclass : 'Object',
	#instVars : [
		'currentState',
		'cells',
		'currentPlayerIndex',
		'dice',
		'winnerState',
		'spaceShips'
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

	| foundShip |
	foundShip := spaceShips
		             detect: [ :spaceShip | spaceShip identification = shipName ]
		             ifNone: [ ^ Error signal: 'SpaceShip not found' ].
	^ foundShip position
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

	currentState := Started new.
	cells := squares.
	spaceShips := ships collect: [ :nombre | SpaceShip namedAfter: nombre ].
	winnerState := NoWinner new.
	currentPlayerIndex := 1.
	dice := playableDice
]

{ #category : 'accessing - private' }
PharoGame >> moveShip: currentShip [

	currentShip move: (dice roll min: cells) top: cells
]

{ #category : 'accessing - private' }
PharoGame >> nextTurn: shipIndex [

    currentPlayerIndex := (shipIndex rem: spaceShips size) + 1
]

{ #category : 'actions' }
PharoGame >> playTurn [

	| shipName |
	currentState finished ifTrue: [
		Error signal: self restartErrorDescription ].
	shipName := spaceShips at: currentPlayerIndex.
	self moveShip: shipName.
	self verifyWinner: shipName orNextSpaceShipFrom: currentPlayerIndex
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
PharoGame >> verifyWinner: shipName orNextSpaceShipFrom: shipIndex [

	(shipName reachedTheEnd: cells)
		ifTrue: [ self finishGameWith: shipName ]
		ifFalse: [ self nextTurn: shipIndex ]
]

{ #category : 'accessing' }
PharoGame >> winner [

	^ winnerState winner
]
