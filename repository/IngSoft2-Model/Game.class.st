Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'currentState',
		'cells',
		'currentCell',
		'ships',
		'winner'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> createSimulation [

	^ self createSimulationWith: 10 andPlayers: (OrderedCollection withAll: {'sombrero'. 'bote'}).
]

{ #category : 'as yet unclassified' }
Game class >> createSimulationWith: squares [

	^ self createSimulationWith: squares andPlayers: (OrderedCollection withAll: {'sombrero'.}). 
]

{ #category : 'as yet unclassified' }
Game class >> createSimulationWith: squares andPlayers: names [

	squares < 0 ifTrue: [
		Error signal: 'Can start game with negative squares' ].
	names isEmpty ifTrue: [
		Error signal: 'Can start game with no players' ].

	^ self new initializeSimulationWith: squares andPlayers: names
]

{ #category : 'as yet unclassified' }
Game >> currentPositionOfShips [

	^ ships values asOrderedCollection
]

{ #category : 'as yet unclassified' }
Game >> finished [
	^ currentState finished.
]

{ #category : 'initialization' }
Game >> initializeSimulationWith: squares andPlayers: names [
	
	currentState := Started new.
	cells := squares.
	currentCell := 0.
	ships := Dictionary new.
	ships := Dictionary newFrom: (names collect: [:name | name -> 0]).
	winner := 'nobody'.
	
]

{ #category : 'as yet unclassified' }
Game >> playSimulation [

	currentState := Playing new.
	currentState playTurn: self at: 1
]

{ #category : 'as yet unclassified' }
Game >> started [
	^ currentState started.
]

{ #category : 'accessing' }
Game >> throwAt: shipIndex [

	| keys shipName |
	keys := ships keys asOrderedCollection.
	shipName := keys at: shipIndex.
	ships at: shipName put: ((ships at: shipName) + 5 min: cells).
	(ships at: shipName) >= cells
		ifTrue: [
			currentState := Finished new.
			winner := shipName ]
		ifFalse: [
			shipIndex < keys size
				ifTrue: [ currentState playTurn: self at: shipIndex + 1 ]
				ifFalse: [ currentState playTurn: self at: 1 ] ]
]

{ #category : 'as yet unclassified' }
Game >> winner [

	^ winner
]
