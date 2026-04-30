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

	^ self createSimulationWith: 10 andPlayers: 2
]

{ #category : 'as yet unclassified' }
Game class >> createSimulationWith: squares [

	^ self createSimulationWith: squares andPlayers: 1. 
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
Game >> finished [
	^ currentState finished.
]

{ #category : 'initialization' }
Game >> initializeSimulationWith: squares andPlayers: quantity [

	currentState := Started new.
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
