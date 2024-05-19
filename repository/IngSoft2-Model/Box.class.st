Class {
	#name : #Box,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Box >> applyEffect [

	^ 0
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
