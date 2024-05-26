Class {
	#name : #Box,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Box >> applyEffect: spaceships and: turn [

	self subclassResponsibility.
]

{ #category : #accessing }
Box >> isWormhole [
	^ false
]

{ #category : #accessing }
Box >> position [

	^ position
]

{ #category : #accessing }
Box >> position: aPosition [

	position := aPosition
]
