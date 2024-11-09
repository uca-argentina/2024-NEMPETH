Class {
	#name : #Acceleration,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Acceleration >> applyCardEffect: aCardArguments and: aGame [

	| idOfSpaceship idOfSpaceshipAtTurn |
	idOfSpaceship := aCardArguments at: 'idSpaceship'.
	idOfSpaceshipAtTurn := aGame getIdOfSpaceshipAtTurn.
	self
		permanentCardValidationWith: idOfSpaceship
		and: idOfSpaceshipAtTurn.

	aGame addAcceleration.
	aGame addPermanentCardPlayed: self
]

{ #category : #removing }
Acceleration >> removeCardEffect: aCardCollection and: aGame [ 

	aGame removeAcceleration.
	aGame removePermanentCardPlayed: self.
]
