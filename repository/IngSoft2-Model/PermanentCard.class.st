Class {
	#name : #PermanentCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
PermanentCard >> permanentCardValidationWith: idOfSpaceship and: idOfSpaceshipAtTurn [

	idOfSpaceship ~= idOfSpaceshipAtTurn ifTrue: [
		Error signal:
			'A spaceship is trying to play a permanent card and it is not its turn' ]
]

{ #category : #removing }
PermanentCard >> removeCardEffect: aCardCollection and: aGame [ 

	self subclassResponsibility.
]
