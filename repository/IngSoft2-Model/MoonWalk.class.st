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
MoonWalk >> applyEffect: spaceships and: turn [

	| currentSpaceship otherSpaceships |
	
	currentSpaceship := spaceships at: turn.
	otherSpaceships := spaceships select: [ :aSpaceship | aSpaceship ~= currentSpaceship ].
	
	otherSpaceships do: [ :aSpaceship |
		aSpaceship move: -1 * boxesToMove ].

]

{ #category : #initialization }
MoonWalk >> initializeWith: boxesToMoveBackward [

	boxesToMove := boxesToMoveBackward.
]
