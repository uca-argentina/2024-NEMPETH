Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: anErrorBlock raise: anErrorClass withExceptionDo: [ :error | self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
GameTest >> testWhenGameIsCreatedWithLessThanTwoSpaceshipsThenThrowError [

	| spaceships dices aDie |
	aDie := Die of: 4.
	dices := OrderedCollection with: aDie.

	spaceships := OrderedCollection new.

	self
		should: [ Game createWith: spaceships and: dices ]
		raise: Error
		withMessage: 'Game should have a least two spaceships'
]

{ #category : #tests }
GameTest >> testWhenGameIsCreatedWithOneSpaceshipAndOneDieThenReturnOneAndOne [

	| aGame spaceships dices aSpaceship anotherSpaceship aDie |
	
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.
	spaceships := OrderedCollection with: aSpaceship with: anotherSpaceship.
	aDie := Die of: 4.
	dices := OrderedCollection with: aDie.
	
	aGame := Game createWith: spaceships and: dices.
	
	self assert: aGame amountOfSpaceships equals: 2.
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
GameTest >> testWhenGameIsCreatedWithoutDicesThenThrowError [

	| spaceships dices aSpaceship |
	aSpaceship := Spaceship create.
	spaceships := OrderedCollection with: aSpaceship.

	dices := OrderedCollection new.

	self
		should: [ Game createWith: spaceships and: dices ]
		raise: Error
		withMessage: 'Game should have a least one die'
]

{ #category : #tests }
GameTest >> testWhenSpaceshipsMovesThreeBoxesOnAFourBoxesBoardThenGameHasNotEnded [

	| spaceships dices aDie aSpaceship anotherSpaceship aWormholeOne aWormholeTwo aBoxOne aPath aBoard aGame aBoxTwo|
	aDie := LoadedDie of: 3.
	dices := OrderedCollection with: aDie.
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aBoxOne := Box new.
	aBoxTwo := Box new.
	aPath := OrderedCollection
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxOne
					with: aBoxTwo.
	
	aBoard := Board createWith: aPath.
	
	aGame := Game createWith: spaceships and: dices.
	
	aGame playWith: aBoard.

	self deny: (aGame hasEnded: aBoard). 
	
]

{ #category : #tests }
GameTest >> testWhenSpaceshipsMovesThreeBoxesOnAThreeBoxesBoardThenGameHasEnded [

	| spaceships dices aDie aSpaceship anotherSpaceship aWormholeOne aWormholeTwo aBoxOne aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	dices := OrderedCollection with: aDie.
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aBoxOne := Box new.
	aPath := OrderedCollection
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxOne.
	aBoard := Board createWith: aPath.
	
	aGame := Game createWith: spaceships and: dices.
	
	aGame playWith: aBoard.

	self assert: (aGame hasEnded: aBoard). 
	
]
