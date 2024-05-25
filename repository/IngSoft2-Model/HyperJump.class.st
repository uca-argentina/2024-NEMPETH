Class {
	#name : #HyperJump,
	#superclass : #Box,
	#instVars : [
		'collectionOfParsecs',
		'index'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJump class >> createWith: listLength [

	^ self new initializeWith: listLength
]

{ #category : #accessing }
HyperJump >> applyEffect: spaceships and: turn [

	| affectedSpaceship |
	affectedSpaceship := spaceships at: turn.
	affectedSpaceship move: (collectionOfParsecs at: index).
	
	index = collectionOfParsecs size ifTrue: [
		index := 0 ].
	
	index := index + 1
]

{ #category : #initialization }
HyperJump >> initializeWith: boardLength [

	| maxPosibleLengthCollectionOfParsecs maxPosibleValueCollectionOfParsecs |
	index := 1.
	collectionOfParsecs := OrderedCollection new.

	maxPosibleLengthCollectionOfParsecs := (boardLength * 0.25) rounded.
	maxPosibleValueCollectionOfParsecs := (boardLength * 0.5) rounded.

	1 to: maxPosibleLengthCollectionOfParsecs atRandom do: [ :i |
		collectionOfParsecs add: maxPosibleValueCollectionOfParsecs atRandom ].
	
	collectionOfParsecs sort: [ :a :b | a > b ].
]

{ #category : #'as yet unclassified' }
HyperJump >> parsecs [
	^ collectionOfParsecs.
]
