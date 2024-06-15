Class {
	#name : #LoadedDeckTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
LoadedDeckTest >> test001WhenUsingALoadedDeckThenReturnTheCardsGivenWhenCreated [ 
	| cards aDeck |
	
	cards := {
        1 -> Acceleration.
        2 -> Speed.
    } asDictionary.
	aDeck := LoadedDeck createWith: cards.
	self assert: ((aDeck giveACard) isKindOf: Acceleration).
	self assert: ((aDeck giveACard) isKindOf: Speed).
	
]
