Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test001WhenAGameIsCreatedThenASimulationCanStart [
	
	| aGame |
	aGame := Game createSimulation.
	self assert: aGame playSimulation equals: true.
]

{ #category : 'tests' }
GameTest >> test002WhenAGameHasAlreadyStartedThenSimulationCanNotStart [
	
	| aGame |
	aGame := Game createSimulation.
	aGame playSimulation.
	self assert: aGame playSimulation equals: false.
]
