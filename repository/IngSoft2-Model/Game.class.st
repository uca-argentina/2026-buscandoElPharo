Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'currentState',
		'cells',
		'currentCell',
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> createSimulation [

	^ self createSimulationWith: 10
]

{ #category : 'as yet unclassified' }
Game class >> createSimulationWith: squares [

	^ self new initializeSimulationWith: squares. 
]

{ #category : 'as yet unclassified' }
Game class >> createSimulationWith: squares andPlayers: quantity [

	^ self new initializeSimulationWith: squares andPlayers: quantity
]

{ #category : 'as yet unclassified' }
Game >> currentPositionOfShips [

	^ ships
]

{ #category : 'as yet unclassified' }
Game >> finishSimulation [
	^ currentState finished.
]

{ #category : 'as yet unclassified' }
Game >> initializeSimulation [

	currentState := true.
	
]

{ #category : 'initialization' }
Game >> initializeSimulationWith: squares [

	currentState := NotStarted new.
	cells := squares.
	currentCell := 0.
	ships := OrderedCollection withAll: { 0. } 
	
]

{ #category : 'initialization' }
Game >> initializeSimulationWith: squares andPlayers: quantity [

	currentState := NotStarted new.
	cells := squares.
	currentCell := 0.
	ships := OrderedCollection new: quantity withAll: 0
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

{ #category : 'as yet unclassified' }
Game >> throw [

	ships doWithIndex: [ :ship :i |
		ships at: i put: ship + 5.
		(ships at: i) > cells
			ifTrue: [ currentState := Finished new ]
			ifFalse: [ currentState playTurn: self at: i + 1 ] ]
]

{ #category : 'accessing' }
Game >> throwAt: shipIndex [

	ships at: shipIndex put: (ships at: shipIndex) + 5.
	(ships at: shipIndex) > cells
		ifTrue: [ currentState := Finished new ]
		ifFalse: [
			shipIndex < ships size
				ifTrue: [ currentState playTurn: self at: shipIndex + 1 ]
				ifFalse: [ currentState playTurn: self at: 1 ] ]
]
