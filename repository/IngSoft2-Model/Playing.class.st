Class {
	#name : 'Playing',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Playing >> finished [
	^ false.
]

{ #category : 'as yet unclassified' }
Playing >> playTurn: aGame [ 
	self finished ifFalse: [ aGame throw ].
]
