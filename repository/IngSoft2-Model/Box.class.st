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
	^ self new initializeOn: aPosition.
]

{ #category : #initialization }
Box >> initializeOn: aPosition [ 
	position := aPosition.
]

{ #category : #accessing }
Box >> position [
	^ position
]
