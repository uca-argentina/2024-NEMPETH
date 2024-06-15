Class {
	#name : #LoadedDeck,
	#superclass : #Object,
	#instVars : [
		'index',
		'cards',
		'idForCard'
	],
	#classInstVars : [
		'index',
		'cards'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedDeck class >> createWith: aMapsOfCards [

	^ self new initializeWith: aMapsOfCards
]

{ #category : #'as yet unclassified' }
LoadedDeck >> giveACard [

	| card |
	card := (cards at: index) createWithId: idForCard.
	index = cards size ifTrue: [ index := index - cards size ].
	index := index + 1.
	idForCard := idForCard + 1.
	^ card
]

{ #category : #initialization }
LoadedDeck >> initializeWith: aMapsOfCards [
	
	idForCard := 1.
	index := 1.
	cards := aMapsOfCards
]
