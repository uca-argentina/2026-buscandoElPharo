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

{ #category : 'initialization' }
SpaceShip >> initializeSpaceShipWithName: tag [

	name := tag.
	currentPosition := 0
]

{ #category : 'accessing' }
SpaceShip >> position [

	^ currentPosition
]
