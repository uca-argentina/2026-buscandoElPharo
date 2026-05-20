"
I represent a spaceship participating in the game.

A spaceship has an identity and a position on the board.
I know my current position and can move through the board during the game.
"
Class {
	#name : 'SpaceShip',
	#superclass : 'Object',
	#instVars : [
		'name',
		'currentPosition',
		'currentLap'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
SpaceShip class >> invalidNameErrorDescription [

	^ 'SpaceShip must have a name'
]

{ #category : 'creation' }
SpaceShip class >> namedAfter: tag [

	tag isEmpty ifTrue: [
		Error signal: self invalidNameErrorDescription ].
	^ self new initializeSpaceShipWithName: tag
]

{ #category : 'playing' }
SpaceShip >> advanceBy: newRoll top: maxCell from: aGame [

	| newPosition |
	newPosition := currentPosition + newRoll.
	newPosition > maxCell ifTrue: [
		newPosition := newPosition - maxCell.
		currentLap := currentLap + 1.
		aGame checkWinnerFor: self with: self laps ].
	newPosition := newPosition max: 1.
	currentPosition := newPosition
]

{ #category : 'accessing' }
SpaceShip >> identification [

	^ name
]

{ #category : 'initialization' }
SpaceShip >> initializeSpaceShipWithName: tag [

	name := tag.
	currentPosition := 1.
	currentLap := 0.
]

{ #category : 'as yet unclassified' }
SpaceShip >> laps [

	^ currentLap
]

{ #category : 'accessing' }
SpaceShip >> position [

	^ currentPosition
]
