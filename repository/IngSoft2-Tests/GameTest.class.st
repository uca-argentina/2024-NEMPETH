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
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	
	aPath := OrderedCollection
			      with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxOne.
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	
	aGame := Game createWithNumberOfSpaceships: spaceships and: dices andLapsToWin: 1.
	
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
		should: [ Game createWithNumberOfSpaceships: 2 and: dices andLapsToWin: 0 ]
		raise: Error
		withMessage: 'Laps to win should be greater than zero'
]

{ #category : #tests }
GameTest >> test003WhenSpaceshipsCompleteTwoLapsOnATwoLapCompletedGameThenTheSpaceshipWins [

| spaceships dices aDie aSpaceship anotherSpaceship aNormalBoxOne aNormalBoxTwo aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 5.
	aDie add: (OrderedCollection with: 4 with: 3 with: 3).
	dices := OrderedCollection with: aDie.
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.
	
	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	aPath := OrderedCollection
			      with: aWormholeOne
		         with: aWormholeTwo
		         with: aNormalBoxOne
				   with: aNormalBoxTwo.
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	
	aGame := Game createWithNumberOfSpaceships: spaceships and: dices andLapsToWin: 2.
	
	aGame playWith: aBoard.
	aGame playWith: aBoard.
	aGame playWith: aBoard.
	self assert: (aGame checkWinnerOn: aBoard) equals: aSpaceship. 
	
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

	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	
	aSpaceship move: 2.
	boxToCheck := aBoard findBoxIn: (aSpaceship position).
	boxToCheck applyEffect: spaceships and: 1.

	self assert: aSpaceship position equals: 1
]

{ #category : #tests }
GameTest >> test007WhenASpaceshipWinsThenPositionOfAnotherSpaceshipIsOne [

	| dices aDie aWormholeOne aWormholeTwo aBoxOne aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
	dices := OrderedCollection with: aDie.

	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	aBoxOne := Box new.
	aPath := OrderedCollection
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxOne.
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	
	aGame := Game createWithNumberOfSpaceships: 2 and: dices andLapsToWin: 1.
	
	aGame playWith: aBoard.
	aGame playWith: aBoard.
	aGame playWith: aBoard.
	aGame playWith: aBoard.
	
	self assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 1).
]

{ #category : #tests }
GameTest >> test008WhenGameEndedThenReturnTheFinishSpaceshipPositionOnBoard [

	| dices aDie aWormholeOne aWormholeTwo aNormalBoxOne aPath aBoard aGame aNormalBoxTwo aNormalBoxThree |
	aDie := LoadedDie of: 5.
	aDie add: (OrderedCollection
			 with: 4
			 with: 3
			 with: 3
			 with: 3
			 with: 5).
	dices := OrderedCollection with: aDie.

	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.

	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aNormalBoxTwo
		         with: aNormalBoxThree.

	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.

	aGame := Game createWithNumberOfSpaceships: 2 and: dices andLapsToWin: 2.

	aGame playWith: aBoard.
	aGame playWith: aBoard.
	aGame playWith: aBoard.
	aGame playWith: aBoard.
	aGame playWith: aBoard.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 3)
]

{ #category : #tests }
GameTest >> test009WhenGameIsCreatedWithLessThanTwoSpaceshipsThenThrowError [

	| spaceships dices aDie |
	aDie := Die of: 4.
	dices := OrderedCollection with: aDie.

	spaceships := OrderedCollection new.

	self
		should: [ Game createWithNumberOfSpaceships: 0 and: dices andLapsToWin: 1 ]
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
		should: [ Game createWithNumberOfSpaceships: spaceships and: dices andLapsToWin: 1 ]
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
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	aBoxOne := Box new.
	aPath := OrderedCollection
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxOne.
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	
	aGame := Game createWithNumberOfSpaceships: spaceships and: dices andLapsToWin: 1.
	
	aGame playWith: aBoard.

	self assert: (aGame checkWinnerOn: aBoard) equals: aSpaceship.
	
]

{ #category : #tests }
GameTest >> test014WhenSpaceshipMoveToAPositionWhereThereIsNotAnotherSpaceshipThenTheShieldIsNotAffected [

	| dices aDie aBoxOne aBoxTwo aBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 1).
	dices := OrderedCollection with: aDie.

	aBoxOne := NormalBox new.
	aBoxTwo := NormalBox new.
	aBoxThree := NormalBox new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aPath := OrderedCollection
					with: aBoxOne
					with: aBoxTwo
		         with: aWormholeOne
		         with: aWormholeTwo
					with: aBoxThree.
					 
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	aGame := Game createWithNumberOfSpaceships: 2 and: dices andLapsToWin: 1.
	
	aGame playWith: aBoard.
	
	self assert: aGame checkShieldsOfSpaceships 
		equals: (OrderedCollection with: 3 with: 3).
]

{ #category : #tests }
GameTest >> test015WhenTwoSpaceshipsBattleIfThereIsATieThenTheSecondSpaceshipLoseOneShieldAndRestartPositionOne [

	| dices aDie aBoxOne aBoxTwo aBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 1).
	dices := OrderedCollection with: aDie.

	aBoxOne := NormalBox new.
	aBoxTwo := NormalBox new.
	aBoxThree := NormalBox new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aPath := OrderedCollection
					with: aBoxOne
					with: aBoxTwo
		         with: aWormholeOne
		         with: aWormholeTwo
					with: aBoxThree.
					 
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	aGame := Game createWithNumberOfSpaceships: 2 and: dices andLapsToWin: 1.
	
	aGame playWith: aBoard.
	aGame playWith: aBoard.
	
	self assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 1).
]

{ #category : #tests }
GameTest >> test016WhenBothSpaceshipsAreInPositionOneThenTheSpaceshipsAreNotAffectedThisIsASafeZone [

	| dices aDie aBoxOne aBoxTwo aBoxThree aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
	dices := OrderedCollection with: aDie.


	aBoxOne := NormalBox new.
	aBoxTwo := NormalBox new.
	aBoxThree := NormalBox new.

	aPath := OrderedCollection
					with: aBoxOne
					with: aBoxTwo
					with: aBoxThree.
					 
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	aGame := Game createWithNumberOfSpaceships: 2 and: dices andLapsToWin: 1.
	
	aGame playWith: aBoard.
	
	self assert: aGame checkPositionsOfSpaceships  
		equals: (OrderedCollection with: 1 with: 1).
	
	self assert: aGame checkShieldsOfSpaceships 
		equals: (OrderedCollection with: 3 with: 3).
]

{ #category : #tests }
GameTest >> test017WhenPassTurnThenTheSpaceshipRecoverAllShields [

	|  dices aDie aBoxOne aBoxTwo aBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 1 with: 1 with: 2 with: 2).
	dices := OrderedCollection with: aDie.

	aBoxOne := NormalBox new.
	aBoxTwo := NormalBox new.
	aBoxThree := Box new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aPath := OrderedCollection
					with: aBoxOne
					with: aBoxTwo
		         with: aWormholeOne
		         with: aWormholeTwo
					with: aBoxThree.
					 
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	aGame := Game createWithNumberOfSpaceships: 2 and: dices andLapsToWin: 1.
	
	aGame playWith: aBoard.
	aGame playWith: aBoard.
	
	self assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2).
	self assert: aGame checkShieldsOfSpaceships 
		equals: (OrderedCollection with: 2 with: 3).
		
	aGame passTurnOn: aBoard.
	
	self assert: aGame checkShieldsOfSpaceships 
		equals: (OrderedCollection with: 3 with: 3).

]

{ #category : #tests }
GameTest >> test018WhenPassTurnThenTheSpaceshipStaysOnTheSamePlace [

	| dices aDie aNormalBoxOne aNormalBoxTwo aNormalBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 3 with: 1 with: 1).
	dices := OrderedCollection with: aDie.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	aPath := OrderedCollection
					with: aNormalBoxOne
					with: aNormalBoxTwo
		         with: aWormholeOne
		         with: aWormholeTwo
					with: aNormalBoxThree.
					 
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	aGame := Game createWithNumberOfSpaceships: 2 and: dices andLapsToWin: 1.
		
	aGame playWith: aBoard.
	self assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 1).
	aGame playWith: aBoard.
	self assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 3).
	aGame playWith: aBoard.
	self assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 3).
	aGame passTurnOn: aBoard.
	self assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 3).
	aGame playWith: aBoard.
	self assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 5 with: 3).
	
	
]

{ #category : #tests }
GameTest >> test019CheckTheRankingOfSpaceshipsInTheGame [

	| spaceships dices aDie spaceshipOne spaceshipTwo spaceshipThree aNormalBoxOne aNormalBoxTwo aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 5.
	aDie add: (OrderedCollection
			 with: 1
			 with: 3
			 with: 2
			 with: 1
			 with: 5).
	dices := OrderedCollection with: aDie.
	spaceshipOne := Spaceship create.
	spaceshipTwo := Spaceship create.
	spaceshipThree := Spaceship create.

	spaceships := OrderedCollection
		              with: spaceshipOne
		              with: spaceshipTwo
		              with: spaceshipThree.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	aPath := OrderedCollection
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aNormalBoxOne
		         with: aNormalBoxTwo.
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.

	aGame := Game createWithNumberOfSpaceships: spaceships and: dices andLapsToWin: 2.

	aGame playWith: aBoard.
	aGame playWith: aBoard.
	aGame playWith: aBoard.
	aGame playWith: aBoard.
	aGame playWith: aBoard.

	self assert: (aGame checkWinnerOn: aBoard) equals: spaceshipTwo.
	self
		assert: (aGame checkRankingOn: aBoard)
		equals: (OrderedCollection
				 with: spaceshipTwo
				 with: spaceshipThree
				 with: spaceshipOne)
]

{ #category : #tests }
GameTest >> test020CanNotBattleAfterASpaceshipHasWon [

	| dices aDie aSpaceship anotherSpaceship aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 3).
	dices := OrderedCollection with: aDie.
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
					with: aNormalBoxOne
					with: aNormalBoxTwo
					with: aNormalBoxThree
					with: aNormalBoxFour.
					 
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	aGame := Game createWithNumberOfSpaceships: 2 and: dices andLapsToWin: 1.
		
	aGame playWith: aBoard.
	aGame playWith: aBoard.
	aGame playWith: aBoard.
	aGame playWith: aBoard.

	self assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 1).
	
	
]

{ #category : #tests }
GameTest >> test021WhenOnABattleTheSpaceshipsThrowTheSameThenTheOneWhichArrivedLastLose [

	| spaceships dices aDie aSpaceship anotherSpaceship aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 2 with: 2 with: 3 with: 3).
	dices := OrderedCollection with: aDie.
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
					with: aNormalBoxOne
					with: aNormalBoxTwo
					with: aNormalBoxThree
					with: aNormalBoxFour.
					 
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	aGame := Game createWithNumberOfSpaceships: 2 and: dices andLapsToWin: 1.
		
	aGame playWith: aBoard.
	aGame playWith: aBoard.

	self assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 1).
	
	
]
