Class {
	#name : #BlackHole,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
BlackHole >> applyEffect: spaceships and: actualSpaceship [

	actualSpaceship move: -4.
]
