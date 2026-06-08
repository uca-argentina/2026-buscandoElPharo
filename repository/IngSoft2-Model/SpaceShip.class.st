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

{ #category : 'comparing' }
SpaceShip >> > anotherSpaceShip [

	self laps = anotherSpaceShip laps
		ifTrue: [ ^ self position > anotherSpaceShip position ]
		ifFalse: [ ^ self laps > anotherSpaceShip laps ]
]

{ #category : 'as yet unclassified' }
SpaceShip >> advanceBy: aParsec into: aPharoGame [

	self
		advanceBy: (aPharoGame cellsRepresenting: aParsec)
		top: aPharoGame boardSize
		from: aPharoGame
]

{ #category : 'as yet unclassified' }
SpaceShip >> advanceBy: anInteger top: anInteger2 [ 
	self shouldBeImplemented.
]

{ #category : 'playing' }
SpaceShip >> advanceBy: amount top: maxCell from: aGame [

	| newPosition |
	newPosition := currentPosition + amount max: 1.
	self moveTo: newPosition top: maxCell from: aGame
]

{ #category : 'accessing' }
SpaceShip >> identification [

	^ name
]

{ #category : 'initialization' }
SpaceShip >> initializeSpaceShipWithName: tag [

	name := tag.
	currentPosition := 0.
	currentLap := 0.
]

{ #category : 'accessing' }
SpaceShip >> laps [

	^ currentLap
]

{ #category : 'private' }
SpaceShip >> moveTo: newPosition top: maxCell from: aGame [

	| adjustedPosition |
	adjustedPosition := newPosition.

	[ adjustedPosition > maxCell ] whileTrue: [
		adjustedPosition := adjustedPosition - maxCell.
		currentLap := currentLap + 1 ].

	currentPosition := adjustedPosition.
	aGame checkWinnerFor: self with: currentLap
]

{ #category : 'private' }
SpaceShip >> moveToFirstCell [

	currentPosition := 1
]

{ #category : 'accessing' }
SpaceShip >> position [

	^ currentPosition ceiling 
]
