Class {
	#name : #UnavailableState,
	#superclass : #SpaceshipState,
	#instVars : [
		'turnsToWait'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
UnavailableState class >> create [

	^ self new initializeState
]

{ #category : #'as yet unclassified' }
UnavailableState >> initializeState [

	turnsToWait := 2
]

{ #category : #'as yet unclassified' }
UnavailableState >> playTurn: aSpaceship [

	turnsToWait > 0
		ifTrue: [
			turnsToWait := turnsToWait - 1.
			^ false ]
		ifFalse: [
			aSpaceship changeTo: AvailableState create.
			aSpaceship updateShield: -1 * aSpaceship shield + 3.
			^ aSpaceship playTurn ]
]
