Class {
	#name : #SpaceshipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpaceshipTest >> testWhenASpaceshipIsCreatedThenPositionIsZero [
	| aSpaceship |
	aSpaceship := Spaceship create.
	
	self assert: aSpaceship position equals: 0.
]

{ #category : #tests }
SpaceshipTest >> testWhenASpaceshipMovesOnePositionThenReturnPositionOne [

	| aSpaceship |
	aSpaceship := Spaceship create.
	aSpaceship move: 1.

	self assert: aSpaceship position equals: 1
]

{ #category : #tests }
SpaceshipTest >> testWhenASpaceshipMovesTwoAndFivePositionsThenPositionIsSeven [

	| aSpaceship |
	aSpaceship := Spaceship create.
	aSpaceship move: 2.
	aSpaceship move: 5.
	self assert: aSpaceship position equals: 7
]
