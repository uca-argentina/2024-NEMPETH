Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfBoxes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> create: aNumberOfBoxes [ 
	aNumberOfBoxes < 1 ifTrue: [ Error signal: 'Number of boxes should be greater than 0 (zero)' ].
	^ self new initializeWith: aNumberOfBoxes.
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfBoxes [
	numberOfBoxes := aNumberOfBoxes.
]

{ #category : #accessing }
Board >> length [
	^ numberOfBoxes.
]
