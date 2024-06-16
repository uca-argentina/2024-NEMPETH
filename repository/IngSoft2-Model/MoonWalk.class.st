Class {
	#name : #MoonWalk,
	#superclass : #Box,
	#instVars : [
		'boxesToMove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalk class >> createWith: boxesToMoveBackward [

	^ self new initializeWith: boxesToMoveBackward.
]

{ #category : #accessing }
MoonWalk >> applyEffect: spaceships and: actualSpaceship [

	spaceships do: [ :aSpaceship |
		aSpaceship position ~= 1 ifTrue: [
			aSpaceship move: -1 * boxesToMove ] ]
]

{ #category : #initialization }
MoonWalk >> initializeWith: boxesToMoveBackward [

	boxesToMove := boxesToMoveBackward.
]
