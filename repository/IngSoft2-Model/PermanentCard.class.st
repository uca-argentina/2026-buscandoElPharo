Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
PermanentCard >> isInstant [

	^ false
]

{ #category : 'testing' }
PermanentCard >> isPermanent [

	^ true
]

{ #category : 'as yet unclassified' }
PermanentCard >> modifyRoll: aRoll [

	^ aRoll
]

{ #category : 'as yet unclassified' }
PermanentCard >> modifyRoll: aRoll for: aSpaceShip [

	^ aRoll
]

{ #category : 'as yet unclassified' }
PermanentCard >> playedBy: aSpaceShip [

	aSpaceShip removeCard: self
]

{ #category : 'as yet unclassified' }
PermanentCard >> playedBy: aSpaceShip in: aGame [

	aSpaceShip removeCard: self.
	self replayedBy: aSpaceShip in: aGame
]

{ #category : 'as yet unclassified' }
PermanentCard >> replayedBy: aSpaceShip in: aGame [

	aGame activateCard: self
]
