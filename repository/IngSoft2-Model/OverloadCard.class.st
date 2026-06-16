"
I represent an Overload card. When active, I decrease the total dice roll of a target spaceship by 2.
"
Class {
	#name : 'OverloadCard',
	#superclass : 'PermanentCard',
	#instVars : [
		'target'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
OverloadCard class >> targeting: aSpaceShip [

	^ self new initializeTargeting: aSpaceShip
]

{ #category : 'initialization' }
OverloadCard >> initializeTargeting: aSpaceShip [

	target := aSpaceShip
]

{ #category : 'initialization' }
OverloadCard >> isOverloadCard [

	^ true
]

{ #category : 'playing' }
OverloadCard >> modifyRoll: aRoll for: aSpaceShip [

	aSpaceShip = target ifTrue: [ ^ aRoll - 2 ].
	^ aRoll
]
