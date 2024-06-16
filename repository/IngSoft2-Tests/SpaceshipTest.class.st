Class {
	#name : #SpaceshipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpaceshipTest >> test001WhenASpaceshipIsCreatedThenPositionIsZero [
	| aSpaceship |
	aSpaceship := Spaceship createWithId: 1.
	
	self assert: aSpaceship position equals: 1.
]

{ #category : #tests }
SpaceshipTest >> test003WhenASpaceshipMovesTwoAndFivePositionsThenPositionIsSeven [

	| aSpaceship |
	aSpaceship := Spaceship createWithId: 1.
	aSpaceship move: 2.
	aSpaceship move: 5.
	self assert: aSpaceship position equals: 8
]

{ #category : #tests }
SpaceshipTest >> test004WhenTheSpaceshipIsCreatedThenCanPlayTurn [

	| aSpaceship |
	aSpaceship := Spaceship createWithId: 1.

	self assert: aSpaceship playTurn.
	self assert: [ aSpaceship state isKindOf: AvailableState ]
]

{ #category : #tests }
SpaceshipTest >> test005WhenSpaceshipHasZeroShieldsThenChangeToUnavailableState [

	| aSpaceship |
	aSpaceship := Spaceship createWithId: 1.
	aSpaceship updateShield: -3.


	self deny: aSpaceship playTurn.
	self assert: (aSpaceship state isKindOf: UnavailableState)
]

{ #category : #tests }
SpaceshipTest >> test006WhenSpaceshipIsUnavaliablePlayTwoTurnsThenSpaceshipIsAvalibleToPlay [

	| aSpaceship |
	aSpaceship := Spaceship createWithId: 1.
	aSpaceship updateShield: -3.
	
	aSpaceship playTurn.
	aSpaceship playTurn.

	self assert: aSpaceship playTurn.
	self assert: (aSpaceship state isKindOf: AvailableState)
]
