Class {
	#name : #Box,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Box >> applyEffect: spaceships and: actualSpaceship [

	self subclassResponsibility.
]

{ #category : #accessing }
Box >> position [

	^ position
]

{ #category : #accessing }
Box >> position: aPosition [

	position := aPosition
]
