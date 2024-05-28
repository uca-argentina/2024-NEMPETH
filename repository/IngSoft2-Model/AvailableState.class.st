Class {
	#name : #AvailableState,
	#superclass : #SpaceshipState,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AvailableState class >> create [

	^ self new
]

{ #category : #'as yet unclassified' }
AvailableState >> playTurn: aSpaceship [

	aSpaceship shield > 0
		ifTrue: [ ^ true ]
		ifFalse: [
			aSpaceship changeTo: UnavailableState create.
			^ aSpaceship playTurn ]
]
