Class {
	#name : #Mercenary,
	#superclass : #Card,
	#instVars : [
		'idOfActualSpaceship',
		'idOfMercenarySpaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Mercenary >> applyCardEffect: aCardArguments and: aGame [ 
	
	idOfActualSpaceship := aCardArguments at: 'idSpaceship'.
	idOfMercenarySpaceship := aCardArguments at: 'idTargetSpaceship'.
	
	aGame applyMercenary: idOfMercenarySpaceship to: idOfActualSpaceship.
	aGame addPermanentCardPlayed: self.
	
]

{ #category : #removing }
Mercenary >> removeCardEffect: aCardCollection and: aGame [ 

	aGame removeMercenary: idOfMercenarySpaceship and: idOfActualSpaceship.	
	aGame removePermanentCardPlayed: self.

]
