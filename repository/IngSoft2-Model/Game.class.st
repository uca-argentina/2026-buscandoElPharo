"
Key collaborators:
- Dice: Provides the movement values.
- State (Started/Finished): Handles the game lifecycle.
- ships: A Dictionary for positions.
- turnOrder: An OrderedCollection to ensure deterministic turns.
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'currentState',
		'cells',
		'ships',
		'currentPlayerIndex',
		'dice',
		'winnerState'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
Game class >> invalidPlayersErrorDescription [

	^ 'Can not start game with no players'
]

{ #category : 'validation' }
Game class >> invalidSquaresErrorDescription [

	^ 'Can not start game with less than 1 square'
]

{ #category : 'creation' }
Game class >> playedOn: squares by: names throwing: aDice [ 

	names isEmpty ifTrue: [
		Error signal: self invalidPlayersErrorDescription ].
	squares < 1 ifTrue: [
		Error signal: self invalidSquaresErrorDescription ].

	^ self new initializeSimulationWith: squares andPlayers: names using: aDice 
]

{ #category : 'accessing' }
Game >> currentPositionOfShip: shipName [ 
	
	^ ships at: shipName ifAbsent: [ ^Error signal: 'Ship name not found' ].
]

{ #category : 'accessing' }
Game >> currentPositionOfShips [

	^ ships values asOrderedCollection copy
]

{ #category : 'accessing - private' }
Game >> finishGameWith: shipName [

	currentState := Finished new.
	winnerState := Winner with: shipName
]

{ #category : 'accessing' }
Game >> finished [

	^ currentState finished
]

{ #category : 'testing' }
Game >> hasWinner [

	^ winnerState hasWon.
]

{ #category : 'initialization' }
Game >> initializeSimulationWith: squares andPlayers: names using: playableDice [

	currentState := Started new.
	cells := squares.
	ships := Dictionary new.
	ships := Dictionary newFrom: (names collect: [ :name | name -> 0 ]).
	winnerState := NoWinner new.
	currentPlayerIndex := 1.
	dice := playableDice
]

{ #category : 'accessing - private' }
Game >> moveShip: shipIndex [

	ships at: shipIndex put: ((ships at: shipIndex) + (dice roll) min: cells)
]

{ #category : 'accessing - private' }
Game >> nextTurn: shipIndex at: keys [

	currentPlayerIndex := (shipIndex rem: keys size) + 1
	

]

{ #category : 'accessing' }
Game >> playTurn [

	| keys shipName |
	currentState finished ifTrue: [
		^ Error signal: 'Can not restart the game' ].
	keys := ships keys asOrderedCollection.
	shipName := keys at: currentPlayerIndex.
	self moveShip: shipName.
	self
		verifyWinner: shipName
		orNextPlayerFrom: currentPlayerIndex
		using: keys
]

{ #category : 'validation' }
Game >> restartErrorDescription [

	^ 'Can not restart the game'
]

{ #category : 'accessing' }
Game >> started [

	^ currentState started 
]

{ #category : 'accessing - private' }
Game >> verifyWinner: shipName orNextPlayerFrom: shipIndex using: keys [

	(ships at: shipName) >= cells
		ifTrue: [ self finishGameWith: shipName ]
		ifFalse: [ self nextTurn: shipIndex at: keys ]
]

{ #category : 'accessing' }
Game >> winner [

	^ winnerState winner
]
