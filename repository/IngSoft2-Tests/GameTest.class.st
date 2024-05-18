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
GameTest >> testWhenASpaceshipIsOnFirstWormholeThenSpaceshipMovesToPositionFive [

	| spaceships dices aDie aSpaceship anotherSpaceship aWormholeOne aWormholeTwo aBoxOne aPath aBoard aGame aBoxTwo aBoxThree |
	aDie := LoadedDie of: 3.
	dices := OrderedCollection with: aDie.
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	aBoxOne := Box new.
	aBoxTwo := Box new.
	aBoxThree := Box new.

	aPath := OrderedCollection
		         with: aBoxOne
		         with: aBoxTwo
		         with: aWormholeOne
		         with: aBoxThree
		         with: aWormholeTwo.
	aBoard := Board createWith: aPath.

	aGame := Game createWith: spaceships and: dices.

	aGame playWith: aBoard.

	self assert: aSpaceship position equals: 5
]

{ #category : #tests }
GameTest >> testWhenASpaceshipIsOnFirstWormholeThenSpaceshipMovesToPositionThree [

	| spaceships aSpaceship anotherSpaceship aWormholeOne aWormholeTwo aBoxOne aPath aBoard aBoxTwo aBoxThree |
	
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aBoxOne := Box new.
	aBoxTwo := Box new.
	aBoxThree := Box new.
	
	aPath := OrderedCollection
					with: aBoxOne
					with: aBoxTwo
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxThree.
	aBoard := Board createWith: aPath.
	
	aSpaceship move: 3.
	aBoard verifyBoxOf: aSpaceship.

	self assert: (aSpaceship position) equals: 4.
]

{ #category : #tests }
GameTest >> testWhenASpaceshipIsOnSecondWormholeThenSpaceshipMovesToPositionOne [

	| spaceships aSpaceship anotherSpaceship aWormholeOne aWormholeTwo aBoxOne aPath aBoard aBoxTwo aBoxThree |
	
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aBoxOne := Box new.
	aBoxTwo := Box new.
	aBoxThree := Box new.

	aPath := OrderedCollection
		         with: aWormholeTwo
		         with: aBoxOne
		         with: aWormholeOne
		         with: aBoxTwo
		         with: aBoxThree.

	aBoard := Board createWith: aPath.
	
	aSpaceship move: 3.
	aBoard verifyBoxOf: aSpaceship.

	self assert: aSpaceship position equals: 1
]

{ #category : #tests }
GameTest >> testWhenASpaceshipWinsThenPositionOfAnotherSpaceshipIsZero [

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

	self assert: (aSpaceship position) equals: 3. 
	self assert: (anotherSpaceship position) equals: 0.
]

{ #category : #tests }
GameTest >> testWhenGameEndedThenReturnTheFinishSpaceshipPositionOnBoard [

	| spaceships dices aDie aSpaceship anotherSpaceship aWormholeOne aWormholeTwo aBoxOne aPath aBoard aGame aBoxTwo aBoxThree |
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
	aBoxThree := Box new.
	
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	
	aPath := OrderedCollection
		         with: aBoxOne
					with: aWormholeOne
		         with: aBoxTwo
					with: aWormholeTwo
		         with: aBoxThree.
		         
	aBoard := Board createWith: aPath.

	aGame := Game createWith: spaceships and: dices.

	aGame playWith: aBoard.
	
	self assert: (aGame checkPositionsIn: aBoard) equals: (OrderedCollection with: 5 with: 3).
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
GameTest >> testWhenSpaceshipsMoveThreeBoxesThenASpaceshipWins [

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

	self assert: (aGame checkWinnerOn: aBoard) equals: aSpaceship.
	
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
