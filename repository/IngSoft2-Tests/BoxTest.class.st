Class {
	#name : #BoxTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoxTest >> test001WhenSpaceshipIsOnBlackHoleBoxThenSpaceshipMovesBackFourBoxes [
	
	|actualSpaceship aSpaceship anotherSpaceship spaceships aBlackHole|
	
	aSpaceship := Spaceship createWithId: 1.
	anotherSpaceship := Spaceship createWithId: 2.
	spaceships := OrderedCollection new.
	spaceships add: aSpaceship; add: anotherSpaceship.
	
	aBlackHole := BlackHole new.
	aSpaceship move: 4.
	actualSpaceship := spaceships removeFirst.
	
	self assert: aSpaceship position equals: 5.
	self assert: anotherSpaceship position equals: 1.
	aBlackHole applyEffect: spaceships and: actualSpaceship.
	
	self assert: aSpaceship position equals: 1.
	self assert: anotherSpaceship position equals: 1.
	
]

{ #category : #tests }
BoxTest >> test002WhenSpaceshipIsOnHyperSpaceJumpBoxThenSpaceshipMovesFourBoxesAndLosesOneShield [
	
	|aSpaceship anotherSpaceship spaceships aHyperSpaceJump actualSpaceship|
	
	aSpaceship := Spaceship createWithId: 1.
	anotherSpaceship := Spaceship createWithId: 2.
	spaceships := OrderedCollection new.
	spaceships add: aSpaceship; add: anotherSpaceship.
	
	aHyperSpaceJump := HyperSpaceJump new.
	actualSpaceship := spaceships removeFirst.
	
	self assert: aSpaceship position equals: 1.
	self assert: aSpaceship shield equals: 3.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship shield equals: 3.
	
	aHyperSpaceJump applyEffect: spaceships and: actualSpaceship.
	
	self assert: aSpaceship position equals: 5.
	self assert: aSpaceship shield equals: 2.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship shield equals: 3.
	
]

{ #category : #tests }
BoxTest >> test003WhenSpaceshipIsOnAtomicBombBoxThenAllSpaceshipMovesToPositionOneAndLosesOneShieldExceptForSpaceshipsOnSafeZone [
	
	|spaceshipOne spaceshipTwo spaceshipThree spaceships aAtomicBomb actualSpaceship |
	
	spaceshipOne := Spaceship createWithId: 1.
	spaceshipTwo := Spaceship createWithId: 2.
	spaceshipThree := Spaceship createWithId: 3.
	
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
	
	actualSpaceship := spaceships removeFirst.
	aAtomicBomb applyEffect: spaceships and: actualSpaceship.
	
	self assert: spaceshipOne position equals: 1.
	self assert: spaceshipOne shield equals: 2.
	self assert: spaceshipTwo position equals: 1.
	self assert: spaceshipTwo shield equals: 2.
	self assert: spaceshipThree position equals: 1.
	self assert: spaceshipThree shield equals: 3.
	
]

{ #category : #tests }
BoxTest >> test004WhenSpaceshipIsOnMoonWalkThenTheOtherSpaceshipsMovesBackTwoPositionsExceptForTheOnesOnTheSafeZone [
	
	|spaceshipOne spaceshipTwo spaceshipThree spaceships aMoonWalk actualSpaceship|
	
	spaceshipOne := Spaceship createWithId: 1.
	spaceshipTwo := Spaceship createWithId: 2.
	spaceshipThree := Spaceship createWithId: 3.
	
	spaceships := OrderedCollection new.
	spaceships add: spaceshipOne; add: spaceshipTwo;add:spaceshipThree.
	
	aMoonWalk := MoonWalk createWith: 2.
	actualSpaceship := spaceships removeFirst.
		
	spaceshipOne move: 4.
	spaceshipTwo move: 2.
	
	self assert: spaceshipOne position equals: 5.
	self assert: spaceshipTwo position equals: 3.
	self assert: spaceshipThree position equals: 1.

	aMoonWalk applyEffect: spaceships and: actualSpaceship.
	
	self assert: spaceshipOne position equals: 5.
	self assert: spaceshipTwo position equals: 1.
	self assert: spaceshipThree position equals: 1.
	
]

{ #category : #tests }
BoxTest >> test005WhenASpaceshipIsOnHyperJumpThenSpaceshipMovesASelectedAmountOfParsecs [
	
	|spaceshipOne spaceshipTwo spaceshipThree spaceships aHyperJump|
	
	spaceshipOne := Spaceship createWithId: 1.
	spaceshipTwo := Spaceship createWithId: 2.
	spaceshipThree := Spaceship createWithId: 3.
	
	spaceships := OrderedCollection new.
	spaceships add: spaceshipOne; add: spaceshipTwo;add:spaceshipThree.

	aHyperJump := LoadedHyperJump createWith: 3 andParsecsToBoxesRatio: 2.
	aHyperJump addParsecs: (OrderedCollection with: 6 with: 4 with: 3).

	spaceshipOne move: 4.
	spaceshipTwo move: 2.
	
	self assert: spaceshipOne position equals: 5.
	self assert: spaceshipTwo position equals: 3.

	aHyperJump applyEffect: spaceships and: 1.
	aHyperJump applyEffect: spaceships and: 2.

	self assert: spaceshipOne position equals: 8.
	self assert: spaceshipTwo position equals: 5.
]

{ #category : #tests }
BoxTest >> test006WhenAmountOfEffectsAppliedAreMoreThanCollectionOfParsecsThenStartFromBeginning [
	
	|spaceshipOne spaceshipTwo spaceshipThree spaceships aHyperJump|
	
	spaceshipOne := Spaceship createWithId: 1.
	spaceshipTwo := Spaceship createWithId: 2.
	spaceshipThree := Spaceship createWithId: 3.
	
	spaceships := OrderedCollection new.
	spaceships add: spaceshipOne; add: spaceshipTwo;add:spaceshipThree.

	aHyperJump := LoadedHyperJump createWith: 2 andParsecsToBoxesRatio: 2.
	aHyperJump addParsecs: (OrderedCollection with: 4 with: 2).

	spaceshipOne move: 1.
	spaceshipTwo move: 1.
	spaceshipThree move: 1.
	
	self assert: spaceshipOne position equals: 2.
	self assert: spaceshipTwo position equals: 2.
	self assert: spaceshipThree position equals: 2.

	aHyperJump applyEffect: spaceships and: 1.
	aHyperJump applyEffect: spaceships and: 2.
	aHyperJump applyEffect: spaceships and: 3.
	
	self assert: spaceshipOne position equals: 4.
	self assert: spaceshipTwo position equals: 3.
	self assert: spaceshipThree position equals: 4.
	
]

{ #category : #tests }
BoxTest >> test007VerifyCorrectCreationOfHyperJumpBox [

	| aHyperJump sortedColletion |
	
	aHyperJump := HyperJump createWith: 40 andParsecsToBoxesRatio: 2.

	self assert: aHyperJump parsecs size <= 10.
	self assert: (aHyperJump parsecs anySatisfy: [ :each | each <= (40 * 0.8) ]).

	sortedColletion := aHyperJump parsecs sort: [ :a :b | a > b ].

	self assert: aHyperJump parsecs equals: sortedColletion.
]

{ #category : #tests }
BoxTest >> test008WhenHyperJumpApplyEffectThenSpaceshipIsMoveBetweenOneAndTwentyBoxes [

	| aHyperJump spaceships aSpaceship anotherSpaceship actualSpaceship |
	
	aSpaceship := Spaceship createWithId: 1.
	anotherSpaceship := Spaceship createWithId: 2.
	spaceships := OrderedCollection with: aSpaceship with: anotherSpaceship.
	actualSpaceship := spaceships removeFirst.
	
	aHyperJump := HyperJump createWith: 40 andParsecsToBoxesRatio: 2.
	
	aHyperJump applyEffect: spaceships and: actualSpaceship. 

	self assert: ((aSpaceship position) between: 2 and: 21).
	self assert: anotherSpaceship position equals: 1.	
]
