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
Game >> currentPositionOfShips [

	| bananaShips |
	bananaShips := OrderedCollection new.
	bananaShips add: (ships at:1).
	^ bananaShips
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

{ #category : 'as yet unclassified' }
Game >> playSimulation [

	currentState := Playing new.
	currentState playTurn: self.
]

{ #category : 'as yet unclassified' }
Game >> started [
	^ currentState started.
]

{ #category : 'as yet unclassified' }
Game >> throw [

	currentCell := 5 + currentCell.
	ships do: [ :ship | ship put: (ship + 5 )].
	currentCell > cells
		ifFalse: [ currentState playTurn: self ]
		ifTrue: [ currentState := Finished new ]
]
