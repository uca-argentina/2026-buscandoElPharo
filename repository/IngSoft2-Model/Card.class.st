"
'I represent the abstract concept of a card within the game. I define the interface and common behavior for all card types.'.
"
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

{ #category : 'playing' }
Card >> playedBy: aSpaceShip [ 
	^ self subclassResponsibility
]

{ #category : 'playing' }
Card >> playedBy: aSpaceShip in: aGame [ 
	^ self subclassResponsibility
]

{ #category : 'playing' }
Card >> replayedBy: aSpaceShip in: aGame [ 
	^ self subclassResponsibility
]

{ #category : 'testing' }
Card >> shouldBeRememberedAsLastPlayedCard [

	^ true
]
