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

	idOfAffectedSpaceship := aCardArguments at: 'idTargetSpaceship'.
	aGame applySpeedWith: idOfAffectedSpaceship.
	aGame addPermanentCardPlayed: self.
	
]

{ #category : #removing }
Speed >> removeCardEffect: aCardArguments and: aGame [ 

	aGame removeSpeedWith: idOfAffectedSpaceship.
	aGame removePermanentCardPlayed: self.
]
