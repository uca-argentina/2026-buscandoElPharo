"
I represent an Acceleration card. When active, I increase the total dice roll of all spaceships in the game by 1.
"
Class {
	#name : 'AccelerationCard',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AccelerationCard >> isAccelerationCard [

	^ true
]

{ #category : 'playing' }
AccelerationCard >> modifyRoll: aRoll for: aSpaceShip [

	^ aRoll + 1
]
