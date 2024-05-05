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

	^ self new initializeWith: aCollectionOfSpaceships and: aCollectionOfDices.
	
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
