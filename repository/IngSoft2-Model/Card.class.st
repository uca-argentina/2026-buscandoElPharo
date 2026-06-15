Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Card >> isAccelerationCard [

	^ false
]

{ #category : 'testing' }
Card >> isInstant [

	^ false
]

{ #category : 'testing' }
Card >> isOverloadCard [

	^ false
]

{ #category : 'testing' }
Card >> isPermanent [

	^ false
]

{ #category : 'testing' }
Card >> isSpeedCard [

	^ false
]

{ #category : 'testing' }
Card >> shouldBeRememberedAsLastPlayedCard [

	^ true
]
