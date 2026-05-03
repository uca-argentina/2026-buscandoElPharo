Class {
	#name : 'Finished',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Finished >> finished [
	^ true.
]

{ #category : 'as yet unclassified' }
Finished >> playTurn: aGame [

	^ Error signal: 'Cannot play a finished game'
]

{ #category : 'as yet unclassified' }
Finished >> started [
	^ true.
]
