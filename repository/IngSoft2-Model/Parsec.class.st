"
I represent a distance measured in parsecs.

I behave as a domain object and can be compared with other parsec values.
"
Class {
	#name : 'Parsec',
	#superclass : 'Object',
	#instVars : [
		'distance'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Parsec class >> distance: aDistance [

	^ self new initializeWithDistance: aDistance
]

{ #category : 'comparing' }
Parsec >> > anotherParsec [

	^ distance > anotherParsec distance
]

{ #category : 'accessing' }
Parsec >> distance [

	^ distance
]

{ #category : 'initialization' }
Parsec >> initializeWithDistance: aDistance [

	distance := aDistance
]
