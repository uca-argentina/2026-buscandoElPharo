"
I represent a permanent card. I can only be played during the turn of the spaceship that owns me, and my effect remains active until removed.
"
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

{ #category : 'playing' }
PermanentCard >> modifyRoll: aRoll [

	^ aRoll
]

{ #category : 'playing' }
PermanentCard >> modifyRoll: aRoll for: aSpaceShip [

	^ aRoll
]

{ #category : 'playing' }
PermanentCard >> playedBy: aSpaceShip [

	aSpaceShip removeCard: self
]

{ #category : 'playing' }
PermanentCard >> playedBy: aSpaceShip in: aGame [

	aGame currentShip = aSpaceShip identification ifFalse: [
		Error signal:
			'Permanent cards can only be played during the spaceship''s turn'].
	aSpaceShip removeCard: self.
	self replayedBy: aSpaceShip in: aGame
]

{ #category : 'playing' }
PermanentCard >> replayedBy: aSpaceShip in: aGame [

	aGame activateCard: self
]
