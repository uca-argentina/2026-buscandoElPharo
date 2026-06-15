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
