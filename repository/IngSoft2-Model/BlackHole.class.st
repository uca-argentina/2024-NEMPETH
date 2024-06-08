Class {
	#name : #BlackHole,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
BlackHole >> applyEffect: spaceships and: turn [
	
	| affectedSpaceship |
	affectedSpaceship := spaceships at: turn.
	affectedSpaceship move: -4.
]
