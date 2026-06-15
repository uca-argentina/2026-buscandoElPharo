Class {
	#name : 'SpeedCard',
	#superclass : 'PermanentCard',
	#instVars : [
		'target'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpeedCard class >> targeting: aSpaceShip [

	^ self new initializeTargeting: aSpaceShip
]

{ #category : 'initialization' }
SpeedCard >> initializeTargeting: aSpaceShip [

	target := aSpaceShip
	
]

{ #category : 'initialization' }
SpeedCard >> isSpeedCard [

	^ true
]

{ #category : 'as yet unclassified' }
SpeedCard >> modifyRoll: aRoll [

	^ aRoll + 1
]

{ #category : 'as yet unclassified' }
SpeedCard >> modifyRoll: aRoll for: aSpaceShip [

	aSpaceShip = target ifTrue: [ ^ aRoll + 1 ].
	^ aRoll
]
