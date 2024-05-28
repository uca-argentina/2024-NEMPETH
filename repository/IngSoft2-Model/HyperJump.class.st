Class {
	#name : #HyperJump,
	#superclass : #Box,
	#instVars : [
		'collectionOfParsecs',
		'index',
		'parsecsToBoxesRatio'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJump class >> createWith: listLength andParsecsToBoxesRatio: aRatio [ 

	^ self new initializeWith: listLength and: aRatio.
]

{ #category : #accessing }
HyperJump >> applyEffect: spaceships and: turn [

	| affectedSpaceship |
	affectedSpaceship := spaceships at: turn.
	affectedSpaceship move: (collectionOfParsecs at: index) // parsecsToBoxesRatio .
	
	index = collectionOfParsecs size ifTrue: [
		index := 0 ].
	
	index := index + 1
]

{ #category : #initialization }
HyperJump >> initializeWith: boardLength and: aRatio [ 

	| maxPosibleLengthCollectionOfParsecs maxPosibleValueCollectionOfParsecs uniqueValuesSet setLength|
	index := 1.
	collectionOfParsecs := OrderedCollection new.
	parsecsToBoxesRatio := aRatio.

	maxPosibleLengthCollectionOfParsecs := (boardLength * 0.25) rounded.
	setLength := maxPosibleLengthCollectionOfParsecs atRandom. 
	maxPosibleValueCollectionOfParsecs := (boardLength * 0.8) rounded. 
	
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
