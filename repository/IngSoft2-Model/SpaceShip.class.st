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
		'currentPosition'
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

{ #category : 'validation' }
SpaceShip class >> repeatedNameErrorDescription [

	^ 'SpaceShips can not have the same name'
]

{ #category : 'playing' }
SpaceShip >> advanceBy: newPosition [

	currentPosition := currentPosition + newPosition
]

{ #category : 'as yet unclassified' }
SpaceShip >> identification [

	^ name
]

{ #category : 'initialization' }
SpaceShip >> initializeSpaceShipWithName: tag [

	name := tag.
	currentPosition := 1
]

{ #category : 'accessing' }
SpaceShip >> move: nextMove [

	currentPosition := currentPosition + nextMove
]

{ #category : 'as yet unclassified' }
SpaceShip >> move: nextMove top: maxMove [

	currentPosition := (currentPosition + nextMove) min: maxMove
]

{ #category : 'accessing' }
SpaceShip >> nameTag [

	^ name
]

{ #category : 'accessing' }
SpaceShip >> position [

	^ currentPosition
]

{ #category : 'playing' }
SpaceShip >> reachedTheEnd: lastCell [

	^ currentPosition = lastCell
]
