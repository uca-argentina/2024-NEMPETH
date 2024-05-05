Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testWhenGameIsCreatedWithOneSpaceshipAndOneDieThenReturnOneAndOne [

	| aGame spaceships dices aSpaceship aDie |
	
	aSpaceship := Spaceship create.
	spaceships := OrderedCollection with: aSpaceship.
	aDie := Die of: 4.
	dices := OrderedCollection with: aDie.
	
	aGame := Game createWith: spaceships and: dices.
	
	self assert: aGame amountOfSpaceships equals: 1.
	self assert: aGame amountOfDices equals: 1.
]

{ #category : #tests }
GameTest >> testWhenGameIsCreatedWithTwoSpaceshipsAndTwoDicesThenReturnTwoAndTwo [

	| aGame spaceships dices aSpaceship aDie anotherSpaceship anotherDie|
	
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.
	spaceships := OrderedCollection with: aSpaceship with: anotherSpaceship.
	aDie := Die of: 4.
	anotherDie := Die of: 4.
	dices := OrderedCollection with: aDie with: anotherDie.
	
	aGame := Game createWith: spaceships and: dices.
	
	self assert: aGame amountOfSpaceships equals: 2.
	self assert: aGame amountOfDices equals: 2.
]

{ #category : #tests }
GameTest >> testbanano [

	| aGame spaceships dices aSpaceship aDie |
	
	aSpaceship := Spaceship create.
	spaceships := OrderedCollection with: aSpaceship.
	aDie := Die of: 4.
	dices := OrderedCollection with: aDie.
	
	aGame := Game createWith: spaceships and: dices.
	
	self assert: aGame amountOfSpaceships equals: 1.
	self assert: aGame amountOfDices equals: 1.
]
