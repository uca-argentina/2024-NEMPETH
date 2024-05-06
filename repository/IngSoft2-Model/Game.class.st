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

{ #category : #'as yet unclassified' }
Game >> checkPositionsIn: aBoard [

	| positions |
	positions := OrderedCollection new.
	spaceships do: [ :aSpaceship |
		aSpaceship position > aBoard length
			ifTrue: [ positions add: aBoard length ]
			ifFalse: [ positions add: aSpaceship position ] ].

	^ positions
]

{ #category : #'as yet unclassified' }
Game >> checkWinnerOn: aBoard [ 
	
	|winner| 
	spaceships do:  [ :aSpaceship |
		(aSpaceship position >= aBoard length)
		ifTrue: [ winner := aSpaceship ] ].
	
	^ winner
]

{ #category : #testing }
Game >> hasEnded: aBoard [

	^ (spaceships at: turn) position >= aBoard length
]

{ #category : #initialization }
Game >> initializeWith: aCollectionOfSpaceships and: aCollectionOfDices [

	turn := 1.
	spaceships := aCollectionOfSpaceships.
	dices := aCollectionOfDices.

]

{ #category : #'as yet unclassified' }
Game >> playWith: aBoard [

	| aSpaceship |
	turn > spaceships size ifTrue: [ turn := 1 ].
	aSpaceship := spaceships at: turn.
	aSpaceship move: self throwDices.
	aBoard verifyBoxOf: aSpaceship.

	(self hasEnded: aBoard) 
	ifTrue: [ 
		aSpaceship position: aBoard length.
		^ self ].
	turn := turn + 1.
	self playWith: aBoard
]

{ #category : #'as yet unclassified' }
Game >> throwDices [

	| sum |
	sum := 0.
	dices do: [ :die | sum := sum + die throw ].
	^ sum
]
