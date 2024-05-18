Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'position',
		'shield',
		'lap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Spaceship class >> create [

	^ self new initializeOn
]

{ #category : #initialization }
Spaceship >> initializeOn [

	position := 1.
	shield := 3.
	lap := 1
]

{ #category : #accessing }
Spaceship >> move: positionsToMove [

	position := position + positionsToMove
]

{ #category : #accessing }
Spaceship >> position [

	^ position
]
