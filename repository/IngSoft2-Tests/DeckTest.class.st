Class {
	#name : #DeckTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DeckTest >> test001WhenTheDeckIsAskedForACardThenGivesACard [

	| aDeck cardOne cardTwo |
	aDeck := Deck create.
	
	cardOne := aDeck giveACard.
	cardTwo := aDeck giveACard.
	
	self assert: (cardOne isKindOf: Card).
	self assert: cardOne id equals: 1.
	self assert: (cardTwo isKindOf: Card).
	self assert: cardTwo id equals: 2.
]
