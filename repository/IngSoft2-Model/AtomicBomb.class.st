"
I represent an AtomicBomb effect.
When applied, I move all spaceships back to the first cell while preserving their completed laps.
"
Class {
	#name : 'AtomicBomb',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
AtomicBomb >> applyTo: spaceShips [

	spaceShips do: [ :spaceShip | spaceShip moveToFirstCell ]
]

{ #category : 'testing' }
AtomicBomb >> isAtomicBomb [

	^ true
]
