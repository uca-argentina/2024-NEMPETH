Class {
	#name : #LoadedHyperJump,
	#superclass : #Object,
	#instVars : [
		'index',
		'collectionOfParsecs',
		'parsecsToBoxesRatio'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedHyperJump class >> createWith: listLength andParsecsToBoxesRatio: aRatio [

	^ self new initializeWith: listLength and: aRatio
]

{ #category : #adding }
LoadedHyperJump >> addParsecs: aCollectionOfParsecs [
 	
	collectionOfParsecs := aCollectionOfParsecs.
]

{ #category : #accessing }
LoadedHyperJump >> applyEffect: spaceships and: turn [

	| affectedSpaceship |
	affectedSpaceship := spaceships at: turn.
	affectedSpaceship move: (collectionOfParsecs at: index) // parsecsToBoxesRatio .
	
	index = collectionOfParsecs size ifTrue: [
		index := 0 ].
	
	index := index + 1
]

{ #category : #initialization }
LoadedHyperJump >> initializeWith: listLength and: aRatio [

	index := 1.
	collectionOfParsecs := OrderedCollection new.
	parsecsToBoxesRatio := aRatio
]
