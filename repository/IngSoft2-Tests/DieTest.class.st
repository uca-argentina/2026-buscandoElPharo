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
				equals: Die dieFacesErrorDescription ]
]

{ #category : 'tests' }
DieTest >> test003WhenDieIsRolledThenResultIsBetweenOneAndNumberOfFaces [

	| die rolledNumber |
	
	die := Die withNumberOfFaces: 6.
	rolledNumber := die roll.
	
	self assert: (rolledNumber between: 1 and: 6)
]

{ #category : 'tests' }
DieTest >> test004WhenFixedDieIsRolledThenItReturnsTheExpectedValue [

	| die |
	
	die := FixedDie rolling: 5.

	self assert: die roll equals: 5
]

{ #category : 'tests' }
DieTest >> test005WhenDiceAreRolledThenItReturnsTheSumOfEachDieRoll [

	| dice firstDie secondDie rolledNumber |
	firstDie := FixedDie rolling: 3.
	secondDie := FixedDie rolling: 5.
	dice := Dice with: {
			        firstDie.
			        secondDie }.
	rolledNumber := dice roll.
	self assert: rolledNumber equals: 8
]

{ #category : 'tests' }
DieTest >> test006WhenFixedDieIsCreatedWithRollLowerThanThreeThenItRaisesAnError [

	self
		should: [ FixedDie rolling: 0 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: FixedDie fixedDieFacesErrorDescription ]
]

{ #category : 'tests' }
DieTest >> test007WhenDiceIsCreatedWithoutAFixedDieThenItRaisesAnError [

	self
		should: [ Dice with: { } ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: Dice mustHaveAtLeastOneFixedDieErrorDescription ]
]
