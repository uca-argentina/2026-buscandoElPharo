Class {
	#name : 'Effect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Effect >> applyTo: aSpaceShip affecting: allShips from: aGame [

	self subclassResponsibility
]

{ #category : 'testing' }
Effect >> isAtomicBomb [

	^ false
]

{ #category : 'testing' }
Effect >> isHyperJump [

	^ false
]

{ #category : 'testing' }
Effect >> isMoonWalk [

	^ false
]

{ #category : 'testing' }
Effect >> isNoEffect [

	^ false
]

{ #category : 'testing' }
Effect >> isSpeedUp [

	^ false
]

{ #category : 'testing' }
Effect >> isWormHole [

	^ false
]
