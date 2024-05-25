Class {
	#name : #LoadedHyperJump,
	#superclass : #Object,
	#instVars : [
		'index',
		'collectionOfParsecs'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedHyperJump class >> createWith: listLength [

	^ self new initializeWith: listLength
]

{ #category : #adding }
LoadedHyperJump >> addParsecs: aCollectionOfParsecs [
 	
	collectionOfParsecs := aCollectionOfParsecs.
]

{ #category : #accessing }
LoadedHyperJump >> applyEffect: spaceships and: turn [

	| affectedSpaceship |
	affectedSpaceship := spaceships at: turn.
	affectedSpaceship move: (collectionOfParsecs at: index).
	
	index = collectionOfParsecs size ifTrue: [
		index := 0 ].
	
	index := index + 1
]

{ #category : #initialization }
LoadedHyperJump >> initializeWith: listLength [

	index := 1.
	collectionOfParsecs := OrderedCollection new.

]
