Class {
	#name : #LoadedDeckTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
LoadedDeckTest >> test001WhenUsingALoadedDeckThenReturnTheCardsGivenWhenCreated [ 
	| cards aDeck cardOne cardTwo cardThree |
	
	cards := {
        1 -> Acceleration.
        2 -> Speed.
    } asDictionary.
	aDeck := LoadedDeck createWith: cards.
	
	cardOne := aDeck giveACard.
	cardTwo := aDeck giveACard.
	cardThree := aDeck giveACard.
	
	self assert: (cardOne isKindOf: Acceleration).
	self assert: cardOne id equals: 1.
	self assert: (cardTwo isKindOf: Speed).
	self assert: cardTwo id equals: 2.	
	self assert: (cardThree isKindOf: Acceleration).
	self assert: cardThree id equals: 3.
]
