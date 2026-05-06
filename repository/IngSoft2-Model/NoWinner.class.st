"
this class represent the absent of a winner.
"
Class {
	#name : 'NoWinner',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
NoWinner >> finished [

	^ false
]

{ #category : 'accessing' }
NoWinner >> winner [

	^ 'nobody'
]
