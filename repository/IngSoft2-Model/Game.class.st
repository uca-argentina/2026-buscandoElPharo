Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'currentState',
		'cells'
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
Game >> initializeSimulation [

	currentState := true.
	
]

{ #category : 'initialization' }
Game >> initializeSimulationWith: squares [.

	currentState := true.
	cells := squares.
	
]

{ #category : 'as yet unclassified' }
Game >> playSimulation [

	| returnState throw |
	returnState := currentState.
	throw := 11.
	throw > cells ifTrue: [ currentState:= false ].
	^ returnState .
]
