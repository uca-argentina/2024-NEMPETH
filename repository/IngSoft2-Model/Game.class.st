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

	aCollectionOfDices  size < 1 ifTrue: [
		Error signal: 'Game should have a least one die' ].

	aCollectionOfSpaceships size < 2 ifTrue: [
		Error signal: 'Game should have a least two spaceships' ].
	
	^ self new
		  initializeWith: aCollectionOfSpaceships
		  and: aCollectionOfDices
]

{ #category : #accessing }
Game >> amountOfDices [
	^ dices size.
]

{ #category : #accessing }
Game >> amountOfSpaceships [
	^ spaceships size.
]

{ #category : #initialization }
Game >> initializeWith: aCollectionOfSpaceships and: aCollectionOfDices [

	turn := 1.
	spaceships := aCollectionOfSpaceships.
	dices := aCollectionOfDices.

]
