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
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
PharoGame class >> invalidShipsErrorDescription [

	^ 'Can not start game with no players'
]

{ #category : 'validation' }
PharoGame class >> invalidSquaresErrorDescription [

	^ 'Can not start game with less than 1 square'
]

{ #category : 'creation' }
PharoGame class >> playedOn: squares by: names throwing: aDice [ 

	names isEmpty ifTrue: [
		Error signal: self invalidShipsErrorDescription ].
	squares < 1 ifTrue: [
		Error signal: self invalidSquaresErrorDescription ].

	^ self new initializePharoGamePlayedOn: squares by: names using: aDice 
]

{ #category : 'accessing' }
PharoGame >> currentPositionOfShip: shipName [

	^ ships
		  at: shipName
		  ifAbsent: [ Error signal: 'Ship name not found' ]
]

{ #category : 'accessing' }
PharoGame >> currentPositionOfShips [

	^ ships values asOrderedCollection copy
]

{ #category : 'accessing - private' }
PharoGame >> finishGameWith: shipName [

	currentState := Finished new.
	winnerState := Winner with: shipName
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
PharoGame >> initializePharoGamePlayedOn: squares by: names using: playableDice [

	currentState := Started new.
	cells := squares.
	ships := Dictionary new.
	ships := Dictionary newFrom:
		              (names collect: [ :name | name -> 0 ]).
	winnerState := NoWinner new.
	currentPlayerIndex := 1.
	dice := playableDice
]

{ #category : 'accessing - private' }
PharoGame >> moveShip: shipIndex [

	ships at: shipIndex put: ((ships at: shipIndex) + (dice roll) min: cells)
]

{ #category : 'accessing - private' }
PharoGame >> nextTurn: shipIndex at: keys [

	currentPlayerIndex := (shipIndex rem: keys size) + 1
	

]

{ #category : 'actions' }
PharoGame >> playTurn [

	| keys shipName |
	currentState finished ifTrue: [
		Error signal: self restartErrorDescription ].
	keys := ships keys asOrderedCollection.
	shipName := keys at: currentPlayerIndex.
	self moveShip: shipName.
	self
		verifyWinner: shipName
		orNextSpaceShipFrom: currentPlayerIndex
		using: keys
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
PharoGame >> verifyWinner: shipName orNextSpaceShipFrom: shipIndex using: keys [

	(ships at: shipName) >= cells
		ifTrue: [ self finishGameWith: shipName ]
		ifFalse: [ self nextTurn: shipIndex at: keys ]
]

{ #category : 'accessing' }
PharoGame >> winner [

	^ winnerState winner
]
