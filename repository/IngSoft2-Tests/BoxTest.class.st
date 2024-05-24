Class {
	#name : #BoxTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoxTest >> test001WhenSpaceshipIsOnBlackHoleBoxThenSpaceshipMovesBackFourBoxes [
	
	|aSpaceship anotherSpaceship spaceships aBlackHole|
	
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.
	spaceships := OrderedCollection new.
	spaceships add: aSpaceship; add: anotherSpaceship.
	
	aBlackHole := BlackHole new.
	aSpaceship move: 4.
	
	self assert: aSpaceship position equals: 5.
	self assert: anotherSpaceship position equals: 1.
	aBlackHole applyEffect: spaceships and: 1.
	
	self assert: aSpaceship position equals: 1.
	self assert: anotherSpaceship position equals: 1.
	
]

{ #category : #tests }
BoxTest >> test002WhenSpaceshipIsOnHyperSpaceJumpBoxThenSpaceshipMovesFourBoxesAndLosesOneShield [
	
	|aSpaceship anotherSpaceship spaceships aHyperSpaceJump|
	
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.
	spaceships := OrderedCollection new.
	spaceships add: aSpaceship; add: anotherSpaceship.
	
	aHyperSpaceJump := HyperSpaceJump new.
	
	self assert: aSpaceship position equals: 1.
	self assert: aSpaceship shield equals: 3.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship shield equals: 3.
	
	aHyperSpaceJump applyEffect: spaceships and: 1.
	
	self assert: aSpaceship position equals: 5.
	self assert: aSpaceship shield equals: 2.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship shield equals: 3.
	
]

{ #category : #tests }
BoxTest >> test003WhenSpaceshipIsOnAtomicBombBoxThenAllSpaceshipMovesToPositionOneAndLosesOneShield [
	
	|spaceshipOne spaceshipTwo spaceshipThree spaceships aAtomicBomb|
	
	spaceshipOne := Spaceship create.
	spaceshipTwo := Spaceship create.
	spaceshipThree := Spaceship create.
	
	spaceships := OrderedCollection new.
	spaceships add: spaceshipOne; add: spaceshipTwo;add:spaceshipThree.
	
	aAtomicBomb := AtomicBomb new.
	
	spaceshipOne move: 4.
	spaceshipTwo move: 2.
	
	self assert: spaceshipOne position equals: 5.
	self assert: spaceshipOne shield equals: 3.
	self assert: spaceshipTwo position equals: 3.
	self assert: spaceshipTwo shield equals: 3.
	self assert: spaceshipThree position equals: 1.
	self assert: spaceshipThree shield equals: 3.
	
	aAtomicBomb applyEffect: spaceships and: 1.
	
	self assert: spaceshipOne position equals: 1.
	self assert: spaceshipOne shield equals: 2.
	self assert: spaceshipTwo position equals: 1.
	self assert: spaceshipTwo shield equals: 2.
	self assert: spaceshipThree position equals: 1.
	self assert: spaceshipThree shield equals: 2.
	
]

{ #category : #tests }
BoxTest >> test004WhenSpaceshipIsOnMoonWalkThenTheOtherSpaceshipsMovesBackTwoPositions [
	
	|spaceshipOne spaceshipTwo spaceshipThree spaceships aMoonWalk|
	
	spaceshipOne := Spaceship create.
	spaceshipTwo := Spaceship create.
	spaceshipThree := Spaceship create.
	
	spaceships := OrderedCollection new.
	spaceships add: spaceshipOne; add: spaceshipTwo;add:spaceshipThree.
	
	aMoonWalk := MoonWalk createWith: 2.
	
	spaceshipOne move: 4.
	spaceshipTwo move: 2.
	spaceshipThree move: 6.
	
	self assert: spaceshipOne position equals: 5.
	self assert: spaceshipTwo position equals: 3.
	self assert: spaceshipThree position equals: 7.

	aMoonWalk applyEffect: spaceships and: 1.
	
	self assert: spaceshipOne position equals: 5.
	self assert: spaceshipTwo position equals: 1.
	self assert: spaceshipThree position equals: 5.
	
]
