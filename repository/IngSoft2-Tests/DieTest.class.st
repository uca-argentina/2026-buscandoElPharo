Class {
	#name : 'DieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DieTest >> test001WhenDieIsCreatedThenItHasTheGivenNumberOfFaces [

	| die |
	
	die := Die withNumberOfFaces: 6.
	
	self assert: die numberOfFaces equals: 6
]

{ #category : 'tests' }
DieTest >> test002WhenDieIsCreatedWithLessThanThreeFacesThenItRaisesAnError [

	self
		should: [ Die withNumberOfFaces: 0 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: Die invalidNumberOfFacesErrorDescription ]
]

{ #category : 'tests' }
DieTest >> test003WhenDieIsRolledThenResultIsBetweenOneAndNumberOfFaces [

	| die rolledNumber |
	
	die := Die withNumberOfFaces: 6.
	rolledNumber := die roll.
	
	self assert: (rolledNumber between: 1 and: 6)
]
