Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTest >> test001WhenDiceAreRolledThenItReturnsTheSumOfEachDieRoll [

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
DiceTest >> test002WhenDiceIsCreatedWithoutAFixedDieThenItRaisesAnError [

	self
		should: [ Dice with: { } ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: Dice mustHaveAtLeastOneFixedDieErrorDescription ]
]
