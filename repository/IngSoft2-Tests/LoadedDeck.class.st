Class {
	#name : #LoadedDeck,
	#superclass : #Object,
	#instVars : [
		'index',
		'cards'
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
	card := (cards at: index) new.
	index = cards size ifTrue: [ index := index - cards size ].
	index := index + 1.
	^ card
]

{ #category : #initialization }
LoadedDeck >> initializeWith: aMapsOfCards [

	index := 1.
	cards := aMapsOfCards
]
