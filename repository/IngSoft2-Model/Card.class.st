Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Card class >> createWithId: anId [

	^ self new initializeWith: anId
]

{ #category : #initialization }
Card >> applyCardEffect: aCardArguments and: aGame [ 

	self subclassResponsibility.
]

{ #category : #accessing }
Card >> id [

	^ id
]

{ #category : #initialization }
Card >> initializeWith: anId [

	id := anId.
]

{ #category : #'as yet unclassified' }
Card >> permanentCardValidationWith: idOfSpaceship and: idOfSpaceshipAtTurn [

	idOfSpaceship ~= idOfSpaceshipAtTurn ifTrue: [
		Error signal:
			'A spaceship is trying to play a permanent card and it is not its turn' ]
]
