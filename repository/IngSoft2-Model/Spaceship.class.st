Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'position',
		'shield',
		'lapsCompleted'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Spaceship class >> create [

	^ self new initializeOn
]

{ #category : #adding }
Spaceship >> addLap [
	lapsCompleted := lapsCompleted + 1
]

{ #category : #initialization }
Spaceship >> initializeOn [

	position := 1.
	shield := 3.
	lapsCompleted := 0
]

{ #category : #accessing }
Spaceship >> lapsCompleted [
	^ lapsCompleted
]

{ #category : #accessing }
Spaceship >> move: positionsToMove [

	position := position + positionsToMove
]

{ #category : #accessing }
Spaceship >> position [

	^ position
]
