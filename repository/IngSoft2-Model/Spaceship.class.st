Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Spaceship class >> create [
	^ self new initializeOn.
]

{ #category : #initialization }
Spaceship >> initializeOn [
	position := 0.
]

{ #category : #accessing }
Spaceship >> move: positionsToMove [ 
	position := position + positionsToMove.
]

{ #category : #accessing }
Spaceship >> position [
	^ position.
]
