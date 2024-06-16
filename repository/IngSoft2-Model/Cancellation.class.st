Class {
	#name : #Cancellation,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Cancellation >> applyCardEffect: aCardArguments and: aGame [ 
	
	| idTargetCard cardAffected |
	idTargetCard := aCardArguments at: 'idTargetCard'.
	cardAffected := (aGame getPermanentCardPlayed) detect: [ :aCard | aCard id = idTargetCard ].
	
	cardAffected removeCardEffect: aCardArguments and: aGame.
	
]
