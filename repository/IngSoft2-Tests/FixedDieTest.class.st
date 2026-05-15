Class {
	#name : 'FixedDieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
FixedDieTest >> test001WhenFixedDieIsRolledThenItReturnsTheExpectedValue [

	| die |
	
	die := FixedDie rolling: 5.

	self assert: die roll equals: 5
]

{ #category : 'tests' }
FixedDieTest >> test002WhenFixedDieIsCreatedWithRollLowerThanThreeThenItRaisesAnError [

	self
		should: [ FixedDie rolling: 0 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: FixedDie fixedDieFacesErrorDescription ]
]
