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

	| maxPosibleLengthCollectionOfParsecs maxPosibleValueCollectionOfParsecs uniqueValuesSet setLength|
	index := 1.
	collectionOfParsecs := OrderedCollection new.

	maxPosibleLengthCollectionOfParsecs := (boardLength * 0.25) rounded.
	setLength := maxPosibleLengthCollectionOfParsecs atRandom. 
	maxPosibleValueCollectionOfParsecs := (boardLength * 0.5) rounded. 
	
    uniqueValuesSet := Set new.
    [ uniqueValuesSet size < setLength ] whileTrue: [
        uniqueValuesSet add: (maxPosibleValueCollectionOfParsecs atRandom).
    ].
	
	collectionOfParsecs := uniqueValuesSet asOrderedCollection.
	collectionOfParsecs sort: [ :a :b | a > b ].
	

]

{ #category : #'as yet unclassified' }
HyperJump >> parsecs [
	^ collectionOfParsecs.
]
