Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'currentState',
		'cells',
		'ships',
		'winner',
		'currentPlayerIndex',
		'dice'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> createSimulation [

	| firstDie secondDie dice |
	firstDie := FixedDie rolling: 2.
	secondDie := FixedDie rolling: 3.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	^ self
		  createSimulationWith: 10
		  andPlayers: (OrderedCollection withAll: { 'sombrero' })
		  using: dice
]

{ #category : 'as yet unclassified' }
Game class >> createSimulationWith: squares [

	| firstDie secondDie dice |
	firstDie := FixedDie rolling: 2.
	secondDie := FixedDie rolling: 3.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	^ self
		  createSimulationWith: squares
		  andPlayers: (OrderedCollection withAll: { 'sombrero' })
		  using: dice
]

{ #category : 'as yet unclassified' }
Game class >> createSimulationWith: squares andPlayers: names [
	
	| firstDie secondDie dice |
	
	names isEmpty ifTrue: [
		Error signal: self invalidPlayersErrorDescription ].
	squares < 1 ifTrue: [
		Error signal: self invalidSquaresErrorDescription ].

	firstDie := FixedDie rolling: 2.
	secondDie := FixedDie rolling: 3.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	^ self
		  createSimulationWith: squares
		  andPlayers: names
		  using: dice
]

{ #category : 'as yet unclassified' }
Game class >> createSimulationWith: squares andPlayers: names using: aDice [ 

	names isEmpty ifTrue: [
		Error signal: self invalidPlayersErrorDescription ].
	squares < 1 ifTrue: [
		Error signal: self invalidSquaresErrorDescription ].

	^ self new initializeSimulationWith: squares andPlayers: names using: aDice 
]

{ #category : 'as yet unclassified' }
Game class >> invalidPlayersErrorDescription [

	^ 'Can not start game with no players'
]

{ #category : 'as yet unclassified' }
Game class >> invalidSquaresErrorDescription [

	^ 'Can not start game with less than 1 squares'
]

{ #category : 'as yet unclassified' }
Game >> currentPositionOfShip: shipName [ 
	
	^ ships at: shipName ifAbsent: [ ^Error signal: 'Ship name not found' ].
]

{ #category : 'as yet unclassified' }
Game >> currentPositionOfShips [

	^ ships values asOrderedCollection
]

{ #category : 'accessing' }
Game >> finishGameWith: shipName [

	currentState := Finished new.
	winner := shipName
]

{ #category : 'as yet unclassified' }
Game >> finished [

	^ currentState finished
]

{ #category : 'initialization' }
Game >> initializeSimulationWith: squares andPlayers: names [

	currentState := Started new.
	cells := squares.
	ships := Dictionary new.
	ships := Dictionary newFrom: (names collect: [ :name | name -> 0 ]).
	winner := 'nobody'.
	currentPlayerIndex := 1
]

{ #category : 'initialization' }
Game >> initializeSimulationWith: squares andPlayers: names using: sequentialDice [

	currentState := Started new.
	cells := squares.
	ships := Dictionary new.
	ships := Dictionary newFrom: (names collect: [ :name | name -> 0 ]).
	winner := 'nobody'.
	currentPlayerIndex := 1.
	dice := sequentialDice
]

{ #category : 'accessing' }
Game >> moveShip: shipIndex [

	ships at: shipIndex put: ((ships at: shipIndex) + (dice roll) min: cells)
]

{ #category : 'accessing' }
Game >> nextTurn: shipIndex at: keys [

	currentPlayerIndex := (shipIndex rem: keys size) + 1
	

]

{ #category : 'as yet unclassified' }
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

{ #category : 'as yet unclassified' }
Game >> started [

	^ currentState started 
]

{ #category : 'accessing' }
Game >> verifyWinner: shipName orNextPlayerFrom: shipIndex using: keys [

	(ships at: shipName) >= cells
		ifTrue: [ self finishGameWith: shipName ]
		ifFalse: [ self nextTurn: shipIndex at: keys ]
]

{ #category : 'as yet unclassified' }
Game >> winner [

	^ winner
]
