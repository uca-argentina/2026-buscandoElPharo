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
