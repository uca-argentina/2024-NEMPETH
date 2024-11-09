Class {
	#name : #Mercenary,
	#superclass : #PermanentCard,
	#instVars : [
		'idOfActualSpaceship',
		'idOfMercenarySpaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Mercenary >> applyCardEffect: aCardArguments and: aGame [

	| idOfSpaceshipAtTurn |
	idOfActualSpaceship := aCardArguments at: 'idSpaceship'.
	idOfMercenarySpaceship := aCardArguments at: 'idTargetSpaceship'.

	idOfSpaceshipAtTurn := aGame getIdOfSpaceshipAtTurn.
	self
		permanentCardValidationWith: idOfActualSpaceship
		and: idOfSpaceshipAtTurn.
	self chooseItselfValidation.

	aGame applyMercenary: idOfMercenarySpaceship to: idOfActualSpaceship.
	aGame addPermanentCardPlayed: self
]

{ #category : #'as yet unclassified' }
Mercenary >> chooseItselfValidation [

	idOfActualSpaceship = idOfMercenarySpaceship ifTrue: [
		Error signal: 'A spaceship can not choose itself as mercenary' ]
]

{ #category : #removing }
Mercenary >> removeCardEffect: aCardCollection and: aGame [ 

	aGame removeMercenary: idOfMercenarySpaceship and: idOfActualSpaceship.	
	aGame removePermanentCardPlayed: self.

]
