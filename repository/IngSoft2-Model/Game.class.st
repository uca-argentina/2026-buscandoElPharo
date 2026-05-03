Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'currentState',
		'cells',
		'ships',
		'winner',
		'currentPlayerIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> createSimulation [

	^ self
		  createSimulationWith: 10
		  andPlayers: (OrderedCollection withAll: { 'sombrero'. })
]

{ #category : 'as yet unclassified' }
Game class >> createSimulationWith: arg1 [

	^ self
		  createSimulationWith: arg1
		  andPlayers: (OrderedCollection withAll: { 'sombrero' })
]

{ #category : 'as yet unclassified' }
Game class >> createSimulationWith: squares andPlayers: names [

	squares < 0 ifTrue: [
		Error signal: 'Can not start game with negative squares' ].
	names isEmpty ifTrue: [
		Error signal: 'Can not start game with no players' ].

	^ self new initializeSimulationWith: squares andPlayers: names
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

{ #category : 'accessing' }
Game >> moveShip: shipIndex [

	ships at: shipIndex put: ((ships at: shipIndex) + 5 min: cells)
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
