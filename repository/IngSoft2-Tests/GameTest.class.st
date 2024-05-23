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
GameTest >> test001WhenSpaceshipsMovesThreeBoxesOnAThreeBoxesBoardWithOneLapToWinThenTheSpaceshipWins [

| spaceships dices aDie aSpaceship anotherSpaceship aBoxOne aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
	dices := OrderedCollection with: aDie.
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.
	
	aBoxOne := Box new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aPath := OrderedCollection
			      with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxOne.
	aBoard := Board createWith: aPath.
	
	aGame := Game createWith: spaceships and: dices andLapsToWin: 1.
	
	aGame playWith: aBoard.

	self assert: (aGame checkWinnerOn: aBoard) equals: aSpaceship. 
	
]

{ #category : #tests }
GameTest >> test002WhenGameIsCreatedWithLessThanOneLapToWinThenThrowError [

	| spaceships dices aDie aSpaceship anotherSpaceship |
	aDie := Die of: 4.
	dices := OrderedCollection with: aDie.

	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.

	self
		should: [ Game createWith: spaceships and: dices andLapsToWin: 0 ]
		raise: Error
		withMessage: 'Laps to win should be greater than zero'
]

{ #category : #tests }
GameTest >> test003WhenSpaceshipsCompleteTwoLapsOnATwoLapCompletedGameThenTheSpaceshipWins [

| spaceships dices aDie aSpaceship anotherSpaceship aBoxOne aBoxTwo aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
	dices := OrderedCollection with: aDie.
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.
	
	aBoxOne := Box new.
	aBoxTwo := Box new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aPath := OrderedCollection
			      with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxOne
				   with: aBoxTwo.
	aBoard := Board createWith: aPath.
	
	aGame := Game createWith: spaceships and: dices andLapsToWin: 2.
	
	aGame playWith: aBoard.

	self assert: (aGame checkWinnerOn: aBoard) equals: aSpaceship. 
	
]

{ #category : #tests }
GameTest >> test004WhenASpaceshipIsOnFirstWormholeThenSpaceshipMovesToPositionFive [

	| spaceships dices aDie aSpaceship anotherSpaceship aWormholeOne aWormholeTwo aBoxOne aPath aBoard aGame aBoxTwo aBoxThree |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
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

	aGame := Game createWith: spaceships and: dices andLapsToWin: 1.

	aGame playWith: aBoard.

	self assert: aSpaceship position equals: 5
]

{ #category : #tests }
GameTest >> test005WhenASpaceshipIsOnFirstWormholeThenSpaceshipMovesToPositionThree [

	| spaceships aSpaceship anotherSpaceship aWormholeOne aWormholeTwo aBoxOne aPath aBoard aBoxTwo aBoxThree boxToCheck |
	
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
					with: aBoxTwo
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxThree.
	aBoard := Board createWith: aPath.
	
	aSpaceship move: 2.
	boxToCheck := aBoard findBoxIn: (aSpaceship position).
	boxToCheck applyEffect: spaceships and: 1.
	

	self assert: (aSpaceship position) equals: 4.
]

{ #category : #tests }
GameTest >> test006WhenASpaceshipIsOnSecondWormholeThenSpaceshipMovesToPositionOne [

	| spaceships aSpaceship anotherSpaceship aWormholeOne aWormholeTwo aBoxOne aPath aBoard aBoxTwo aBoxThree boxToCheck |
	
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
		         with: aWormholeTwo
		         with: aBoxOne
		         with: aWormholeOne
		         with: aBoxTwo
		         with: aBoxThree.

	aBoard := Board createWith: aPath.
	
	aSpaceship move: 2.
	boxToCheck := aBoard findBoxIn: (aSpaceship position).
	boxToCheck applyEffect: spaceships and: 1.

	self assert: aSpaceship position equals: 1
]

{ #category : #tests }
GameTest >> test007WhenASpaceshipWinsThenPositionOfAnotherSpaceshipIsZero [

	| spaceships dices aDie aSpaceship anotherSpaceship aWormholeOne aWormholeTwo aBoxOne aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
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
	
	aGame := Game createWith: spaceships and: dices andLapsToWin: 1.
	
	aGame playWith: aBoard.

	self assert: (aSpaceship position) equals: 3. 
	self assert: (anotherSpaceship position) equals: 1.
]

{ #category : #tests }
GameTest >> test008WhenGameEndedThenReturnTheFinishSpaceshipPositionOnBoard [

	| spaceships dices aDie aSpaceship anotherSpaceship aWormholeOne aWormholeTwo aBoxOne aPath aBoard aGame aBoxTwo aBoxThree |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
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
					with: aWormholeTwo         
					with: aBoxTwo
		         with: aBoxThree.
		         
	aBoard := Board createWith: aPath.

	aGame := Game createWith: spaceships and: dices andLapsToWin: 2.

	aGame playWith: aBoard.
	
	self assert: (aGame checkPositionsIn: aBoard) equals: (OrderedCollection with: 5 with: 3).
]

{ #category : #tests }
GameTest >> test009WhenGameIsCreatedWithLessThanTwoSpaceshipsThenThrowError [

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
GameTest >> test010WhenGameIsCreatedWithoutDicesThenThrowError [

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
GameTest >> test011WhenSpaceshipsMoveThreeBoxesThenASpaceshipWins [

	| spaceships dices aDie aSpaceship anotherSpaceship aWormholeOne aWormholeTwo aBoxOne aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
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
	
	aGame := Game createWith: spaceships and: dices andLapsToWin: 1.
	
	aGame playWith: aBoard.

	self assert: (aGame checkWinnerOn: aBoard) equals: aSpaceship.
	
]

{ #category : #tests }
GameTest >> test013WhenSpaceshipsMovesThreeBoxesOnAThreeBoxesBoardThenGameHasEnded [

	| spaceships dices aDie aSpaceship anotherSpaceship aWormholeOne aWormholeTwo aBoxOne aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
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
	
	aGame := Game createWith: spaceships and: dices andLapsToWin: 1.
	
	aGame playWith: aBoard.

	self assert: (aGame checkWinnerOn: aBoard) equals: aSpaceship. 
	
]

{ #category : #tests }
GameTest >> test014WhenSpaceshipMoveToAPositionWhereThereIsNotAnotherSpaceshipThenTheShieldIsNotAffected [

	| spaceships dices aDie aSpaceship anotherSpaceship aBoxOne aBoxTwo aBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	dices := OrderedCollection with: aDie.
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.

	aBoxOne := Box new.
	aBoxTwo := Box new.
	aBoxThree := Box new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aPath := OrderedCollection
					with: aBoxOne
					with: aBoxTwo
		         with: aWormholeOne
		         with: aWormholeTwo
					with: aBoxThree.
					 
	aBoard := Board createWith: aPath.
	aGame := Game createWith: spaceships and: dices andLapsToWin: 1.
	
	aSpaceship move: 1.
	aGame verifyBattleAt: aSpaceship position.
	
	self assert: aSpaceship shield equals: 3.
]

{ #category : #tests }
GameTest >> test015WhenBothSpaceshipsAreInTheSameBoxThenTheSecondSpaceshipLoseOneShieldAndRestartPositionOne [

	| spaceships dices aDie aSpaceship anotherSpaceship aBoxOne aBoxTwo aBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
	dices := OrderedCollection with: aDie.
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.

	aBoxOne := Box new.
	aBoxTwo := Box new.
	aBoxThree := Box new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aPath := OrderedCollection
					with: aBoxOne
					with: aBoxTwo
		         with: aWormholeOne
		         with: aWormholeTwo
					with: aBoxThree.
					 
	aBoard := Board createWith: aPath.
	aGame := Game createWith: spaceships and: dices andLapsToWin: 1.
	
	aSpaceship move: 1.
	anotherSpaceship move: 1.
	aGame verifyBattleAt: aSpaceship position.
	
	self assert: aSpaceship shield equals: 3.
	self assert: aSpaceship position equals: 2.
	self assert: anotherSpaceship shield equals: 2.
	self assert: anotherSpaceship position equals: 1.
]

{ #category : #tests }
GameTest >> test016WhenBothSpaceshipsAreInPositionOneThenTheSpaceshipsAreNotAffectedThisIsASafeZone [

	| spaceships dices aDie aSpaceship anotherSpaceship aBoxOne aBoxTwo aBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
	dices := OrderedCollection with: aDie.
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.

	aBoxOne := Box new.
	aBoxTwo := Box new.
	aBoxThree := Box new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aPath := OrderedCollection
					with: aBoxOne
					with: aBoxTwo
		         with: aWormholeOne
		         with: aWormholeTwo
					with: aBoxThree.
					 
	aBoard := Board createWith: aPath.
	aGame := Game createWith: spaceships and: dices andLapsToWin: 1.
	
	aGame verifyBattleAt: aSpaceship position.
	
	self assert: aSpaceship shield equals: 3.
	self assert: aSpaceship position equals: 1.
	self assert: anotherSpaceship shield equals: 3.
	self assert: anotherSpaceship position equals: 1.
]

{ #category : #tests }
GameTest >> test017WhenPassTurnThenTheSpaceshipRecoverAllShields [

	| spaceships dices aDie aSpaceship anotherSpaceship aBoxOne aBoxTwo aBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 3 with: 1 with: 1).
	dices := OrderedCollection with: aDie.
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.

	aBoxOne := Box new.
	aBoxTwo := Box new.
	aBoxThree := Box new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aPath := OrderedCollection
					with: aBoxOne
					with: aBoxTwo
		         with: aWormholeOne
		         with: aWormholeTwo
					with: aBoxThree.
					 
	aBoard := Board createWith: aPath.
	aGame := Game createWith: spaceships and: dices andLapsToWin: 1.
	
	aSpaceship updateShield: -2.
	
	aGame passTurnOn: aBoard.
	
	self assert: aSpaceship shield equals: 3.
	
	
	"aGame playWith: aBoard.
	aGame playWith: aBoard.
	aGame playWith: aBoard.
	aGame passTurnOn: aBoard.
	aGame playWith: aBoard.
	
	self assert: aSpaceship shield equals: 3.
	self assert: aSpaceship position equals: 1.
	self assert: anotherSpaceship shield equals: 3.
	self assert: anotherSpaceship position equals: 1."
]

{ #category : #tests }
GameTest >> test018WhenPassTurnThenTheSpaceshipStaysOnTheSamePlace [

	| spaceships dices aDie aSpaceship anotherSpaceship aBoxOne aBoxTwo aBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 3 with: 1 with: 1).
	dices := OrderedCollection with: aDie.
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.

	aBoxOne := Box new.
	aBoxTwo := Box new.
	aBoxThree := Box new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	aPath := OrderedCollection
					with: aBoxOne
					with: aBoxTwo
		         with: aWormholeOne
		         with: aWormholeTwo
					with: aBoxThree.
					 
	aBoard := Board createWith: aPath.
	aGame := Game createWith: spaceships and: dices andLapsToWin: 1.
		
	aGame playWith: aBoard.
	self assert: aSpaceship position equals: 2.
	aGame playWith: aBoard.
	self assert: anotherSpaceship position equals: 3.
	aGame playWith: aBoard.
	self assert: aSpaceship position equals: 4.
	aGame passTurnOn: aBoard.
	self assert: anotherSpaceship position equals: 3.
	aGame playWith: aBoard.
	self assert: aSpaceship position equals: 5.
	
	
]
