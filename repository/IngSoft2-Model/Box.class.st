Class {
	#name : #Box,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Box class >> on: aPosition [
	aPosition < 0 ifTrue: [ Error signal: 'Position should be positive' ].
	^ self new initializeOf: aPosition.
]

{ #category : #initialization }
Box >> initializeOf: aPosition [ 
	position := aPosition.
]

{ #category : #accessing }
Box >> position [
	^ position
]
