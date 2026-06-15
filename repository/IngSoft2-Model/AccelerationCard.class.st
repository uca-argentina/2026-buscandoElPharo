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

{ #category : 'as yet unclassified' }
AccelerationCard >> modifyRoll: aRoll for: aSpaceShip [

	^ aRoll + 1
]
