Class {
	#name : #DeckTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DeckTest >> test001WhenTheDeckIsAskedForACardThenGivesACard [

	| aDeck |
	aDeck := Deck new.
	self assert: ((aDeck giveACard) isKindOf: Card).
]
