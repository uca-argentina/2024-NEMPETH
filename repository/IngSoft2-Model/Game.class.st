Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'turn',
		'spaceships',
		'dices'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> createWith: aCollectionOfSpaceships and: aCollectionOfDices [

	self dicesValidation: aCollectionOfDices.
	self spaceshipsValidation: aCollectionOfSpaceships.

	^ self new
		  initializeWith: aCollectionOfSpaceships
		  and: aCollectionOfDices
]

{ #category : #'instance creation' }
Game class >> dicesValidation: aCollectionOfDices [

	aCollectionOfDices size < 1 ifTrue: [
		Error signal: 'Game should have a least one die' ]
]

{ #category : #'instance creation' }
Game class >> spaceshipsValidation: aCollectionOfSpaceships [

	aCollectionOfSpaceships size < 2 ifTrue: [
		Error signal: 'Game should have a least two spaceships' ]
]

{ #category : #accessing }
Game >> amountOfDices [
	^ dices size.
]

{ #category : #accessing }
Game >> amountOfSpaceships [
	^ spaceships size.
]

{ #category : #testing }
Game >> hasEnded: aBoard [

	^ spaceships anySatisfy: [ :aSpaceship |
		  aSpaceship position >= aBoard length ]
]

{ #category : #initialization }
Game >> initializeWith: aCollectionOfSpaceships and: aCollectionOfDices [

	turn := 1.
	spaceships := aCollectionOfSpaceships.
	dices := aCollectionOfDices.

]

{ #category : #'as yet unclassified' }
Game >> playWith: aBoard [

	| sum |
	spaceships do: [ :aSpaceship |
		sum := 0.
		dices  do: [ :die | sum := sum + die throw ].

		aSpaceship move: sum ]
]
