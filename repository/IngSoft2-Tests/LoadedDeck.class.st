Class {
	#name : #LoadedDeck,
	#superclass : #Object,
	#classInstVars : [
		'index',
		'cards'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedDeck class >> createWith: aCollectionOfCards [

	index := 1.
	cards := aCollectionOfCards
]

{ #category : #'as yet unclassified' }
LoadedDeck class >> giveACard [

	| card |
	card := cards at: index.
	index = cards size ifTrue: [ index := index - cards size ].
	index := index + 1.
	^ card
]
