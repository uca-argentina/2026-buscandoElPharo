"
Key collaborators:
- Game: When I am the current state, I represent the finished state of the game.
"
Class {
	#name : 'Finished',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Finished >> finished [

	^ true
]

{ #category : 'accessing' }
Finished >> started [

	^ false
]
