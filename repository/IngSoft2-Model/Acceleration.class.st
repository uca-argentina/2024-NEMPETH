Class {
	#name : #Acceleration,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Acceleration >> applyCardEffect: aCardArguments and: aGame [ 

	aGame addAcceleration.
	aGame addPermanentCardPlayed: self.
]

{ #category : #removing }
Acceleration >> removeCardEffect: aCardCollection and: aGame [ 
	aGame removeAcceleration.
	aGame removePermanentCardPlayed: self.
]
