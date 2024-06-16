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
	
]
