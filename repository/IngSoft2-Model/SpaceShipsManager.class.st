"
I am responsible for managing the sequence of turns in the game
"
Class {
	#name : 'SpaceShipsManager',
	#superclass : 'Object',
	#instVars : [
		'spaceShipsOrder',
		'currentTurn'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
SpaceShipsManager class >> withShips: names [

	^ self new initializeWithShips: names
]

{ #category : 'accessing' }
SpaceShipsManager >> allShips [

	^ spaceShipsOrder
]

{ #category : 'playing' }
SpaceShipsManager >> currentShip [

	^ spaceShipsOrder at: currentTurn
]

{ #category : 'accessing' }
SpaceShipsManager >> currentShipIdentification [

	^ (spaceShipsOrder at: currentTurn) identification
]

{ #category : 'as yet unclassified' }
SpaceShipsManager >> currentShipIdentification: currentTurn [

	^ (spaceShipsOrder at: currentTurn) identification
]

{ #category : 'initialization' }
SpaceShipsManager >> initializeWithShips: names [

	spaceShipsOrder := names.
]

{ #category : 'accessing' }
SpaceShipsManager >> lapOf: aName [

	^ (spaceShipsOrder detect: [ :ship | ship identification = aName ])
		  laps
]

{ #category : 'accessing' }
SpaceShipsManager >> positionOf: aName [

	^ (spaceShipsOrder detect: [ :ship | ship identification = aName ])
		  position
]

{ #category : 'playing' }
SpaceShipsManager >> rankOfThis: aSpaceShip [

	| sorted ship |
	sorted := spaceShipsOrder asSortedCollection: [ :a :b |
		          a laps > b laps or: [
			          a laps = b laps and: [ a position > b position ] ] ].
	ship := spaceShipsOrder detect: [ :s | s identification = aSpaceShip ].
	^ sorted indexOf: ship
]
