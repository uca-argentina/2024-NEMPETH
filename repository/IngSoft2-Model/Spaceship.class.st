Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'position',
		'shield',
		'lapsCompleted',
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Spaceship class >> create [

	^ self new initializeOn
]

{ #category : #comparing }
Spaceship >> > aSpaceship [

	^ self lapsCompleted > aSpaceship lapsCompleted
		  ifTrue: [ true ]
		  ifFalse: [
			  self lapsCompleted = aSpaceship lapsCompleted
				  ifTrue: [ self position > aSpaceship position ]
				  ifFalse: [ false ] ]
]

{ #category : #adding }
Spaceship >> addLap [
	lapsCompleted := lapsCompleted + 1
]

{ #category : #'as yet unclassified' }
Spaceship >> changeTo: anState [ 
	state := anState.
]

{ #category : #initialization }
Spaceship >> initializeOn [

	position := 1.
	shield := 3.
	lapsCompleted := 0.
	state:= AvailableState create.
]

{ #category : #accessing }
Spaceship >> lapsCompleted [
	^ lapsCompleted
]

{ #category : #accessing }
Spaceship >> move: positionsToMove [

	position := position + positionsToMove
]

{ #category : #'as yet unclassified' }
Spaceship >> playTurn [

	^ state playTurn: self
]

{ #category : #accessing }
Spaceship >> position [

	^ position
]

{ #category : #'as yet unclassified' }
Spaceship >> recoverShields [

	shield := 3
]

{ #category : #accessing }
Spaceship >> shield [
	^ shield
]

{ #category : #accessing }
Spaceship >> state [
	^ state
]

{ #category : #'as yet unclassified' }
Spaceship >> subtractLap [

	lapsCompleted := lapsCompleted - 1
]

{ #category : #'as yet unclassified' }
Spaceship >> updateShield: amount [
	shield := shield + amount.
]
