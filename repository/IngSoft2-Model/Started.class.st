"
Key collaborators:
- Game: I provide the behavior for the 'started' and 'finished' queries while the game is in progress.
"
Class {
	#name : 'Started',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Started >> finished [

	^ false.
]

{ #category : 'accessing' }
Started >> started [

	^ true.
]
