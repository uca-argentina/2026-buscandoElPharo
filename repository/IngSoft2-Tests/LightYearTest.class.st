Class {
	#name : 'LightYearTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
LightYearTest >> test001WhenLightYearsAreConvertedToParsecsThenThreeLightYearsEqualOneParsec [

	| distance |
	distance := LightYear distance: 3.

	self assert: distance asParsecs equals: 1
]

{ #category : 'tests' }
LightYearTest >> test002WhenHyperJumpUsesLightYearsThenItConvertsThemToParsecs [

	| anEffect aBoard tiles |
	tiles := OrderedCollection new.
	10 timesRepeat: [ tiles add: NoEffect new ].

	aBoard := Board withCells: tiles andParsecs: 100.

	anEffect := HyperJump withParsecs:
		            (OrderedCollection with: (LightYear distance: 30)).

	self assert: (anEffect effectImpactOn: aBoard) equals: 1
]
