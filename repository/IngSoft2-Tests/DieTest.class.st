Class {
	#name : 'DieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
DieTest >> test001WhenDieIsCreatedThenItHasTheGivenNumberOfFaces [
	| die |
	die := Die withNumberOfFaces: 6.
	self assert: die numberOfFaces equals: 6.
]

{ #category : 'as yet unclassified' }
DieTest >> test002WhenDieIsCreatedWithLessThanOneFaceThenItRaisesAnError [
	self
		should: [ Die withNumberOfFaces: 0 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: Die invalidNumberOfFacesErrorDescription ]
]

{ #category : 'as yet unclassified' }
DieTest >> test003WhenDieIsRolledThenResultIsBetweenOneAndNumberOfFaces [
	| die rolledNumber |
	die := Die withNumberOfFaces: 6.
	rolledNumber := die roll.
	self assert: (rolledNumber between: 1 and: 6).
]

{ #category : 'as yet unclassified' }
DieTest >> test004WhenDieIsRolledManyTimesThenResultIsBetweenOneAndNumberOfFaces [
	| die rolledNumbers |
	die := Die withNumberOfFaces: 6.
	rolledNumbers := (1 to: 100) collect: [ :eachRoll | die roll ].
	self assert: (rolledNumbers allSatisfy: [ :rolledNumber |
		rolledNumber between: 1 and: 6 ])
]

{ #category : 'as yet unclassified' }
DieTest >> test005WhenDiceAreRolledThenItReturnsTheSumOfEachDieRoll [
	| dice firstDie secondDie rolledNumber |
	firstDie := FixedDie rolling: 3.
	secondDie := FixedDie rolling: 5.
	dice := Dice with: { firstDie. secondDie. }.
	rolledNumber := dice roll.
	self assert: rolledNumber equals: 8.
]

{ #category : 'tests' }
DieTest >> test006WhenDiceAreRolledThenItReturnsTheSumOfEachDieRoll [
	
	| dice firstDie secondDie rolledNumber |
	firstDie := FixedDie rolling: 3.
	secondDie := FixedDie rolling: 5.
	dice := Dice with: { firstDie. secondDie. }.
	
	rolledNumber := dice roll.
	
	self assert: rolledNumber equals: 8.
]
