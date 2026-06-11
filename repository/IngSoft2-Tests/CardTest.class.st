Class {
	#name : 'CardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardTest >> test001WhenAnInstantCardIsCreatedThenItIsInstant [

	| aCard |

	aCard := InstantCard new.

	self assert: aCard isInstant
]

{ #category : 'tests' }
CardTest >> test002WhenAPermanentCardIsCreatedThenItIsPermanent [

	| aCard |

	aCard := PermanentCard new.

	self assert: aCard isPermanent
]

{ #category : 'tests' }
CardTest >> test003WhenAnInstantCardIsCreatedThenItIsNotPermanent [

	| aCard |

	aCard := InstantCard new.

	self deny: aCard isPermanent
]

{ #category : 'tests' }
CardTest >> test004WhenAPermanentCardIsCreatedThenItIsNotInstant [

	| aCard |

	aCard := PermanentCard new.

	self deny: aCard isInstant
]
