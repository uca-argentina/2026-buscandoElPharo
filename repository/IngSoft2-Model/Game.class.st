Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'currentState'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> createSimulation [

	^ self new initializeSimulation
]

{ #category : 'as yet unclassified' }
Game >> initializeSimulation [

	currentState := true.
	
]

{ #category : 'as yet unclassified' }
Game >> playSimulation [

	| returnState |
	returnState := currentState.
	currentState := false.
	^ returnState.
]

{ #category : 'as yet unclassified' }
Game >> startSimulation [
	^ true.
]
