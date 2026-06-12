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

{ #category : 'as yet unclassified' }
OverloadCard >> modifyRoll: aRoll for: aSpaceShip [

	aSpaceShip = target ifTrue: [ ^ aRoll - 2 ].
	^ aRoll
]
