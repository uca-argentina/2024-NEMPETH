Class {
	#name : #HyperSpaceJump,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
HyperSpaceJump >> applyEffect: spaceships and: turn [
	
	| affectedSpaceship |
	affectedSpaceship := spaceships at: turn.
	affectedSpaceship move: 4.
	affectedSpaceship updateShield: -1.
]
