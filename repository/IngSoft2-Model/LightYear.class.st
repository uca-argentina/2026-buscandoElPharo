"
I represent a spatial distance measured in light-years. I can convert my value into parsecs to integrate with the board''s movement logic.
"
Class {
	#name : 'LightYear',
	#superclass : 'Object',
	#instVars : [
		'distance'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
LightYear class >> distance: aDistance [

	^ self new initializeWithDistance: aDistance
]

{ #category : 'initialization' }
LightYear >> asParsecs [

	^ distance / 3
]

{ #category : 'initialization' }
LightYear >> initializeWithDistance: aDistance [

	distance := aDistance
]
