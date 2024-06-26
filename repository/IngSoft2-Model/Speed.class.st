Class {
	#name : #Speed,
	#superclass : #Card,
	#instVars : [
		'idOfAffectedSpaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Speed >> applyCardEffect: aCardArguments and: aGame [

	| idOfSpaceship idOfSpaceshipAtTurn |
	idOfAffectedSpaceship := aCardArguments at: 'idTargetSpaceship'.
	idOfSpaceship := aCardArguments at: 'idSpaceship'.
	idOfSpaceshipAtTurn := aGame getIdOfSpaceshipAtTurn.
	self
		permanentCardValidationWith: idOfSpaceship
		and: idOfSpaceshipAtTurn.
	
	aGame applySpeedWith: idOfAffectedSpaceship.
	aGame addPermanentCardPlayed: self.
	
]

{ #category : #removing }
Speed >> removeCardEffect: aCardArguments and: aGame [ 

	aGame removeSpeedWith: idOfAffectedSpaceship.
	aGame removePermanentCardPlayed: self.
]
