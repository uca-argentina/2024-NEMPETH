Class {
	#name : #SpaceshipState,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
SpaceshipState class >> create [

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
SpaceshipState >> playTurn: aSpaceship [

	self subclassResponsibility.
]
