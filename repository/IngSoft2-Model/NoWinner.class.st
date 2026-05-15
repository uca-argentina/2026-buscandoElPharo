"
this class represent the absent of a winner.
"
Class {
	#name : 'NoWinner',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
NoWinner >> hasWon [

	^ false
]

{ #category : 'accessing' }
NoWinner >> winner [

	^ Error signal: self noWinnerErrorDescription
]
