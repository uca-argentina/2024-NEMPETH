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

	| dices aDie cards aDeck aBoxOne aWormholeOne aWormholeTwo aPath aBoard aGame winner |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aBoxOne := Box new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.

	aPath := OrderedCollection
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxOne.
	aBoard := Board createWith: aPath.

	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.

	winner := aGame checkWinnerOn: aBoard.

	self assert: winner id equals: 1
]

{ #category : #tests }
GameTest >> test002WhenGameIsCreatedWithLessThanOneLapToWinThenThrowError [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aPath aBoard |
	aDie := Die of: 4.
	dices := OrderedCollection with: aDie.
	
	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo.


	aBoard := Board createWith: aPath.
	
	cards := {
        1 -> Acceleration.
        2 -> Speed.
    } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	self
		should: [ Game createWithNumberOfSpaceships: 2 and: dices and: aDeck and: aBoard andLapsToWin: 0 ]
		raise: Error
		withMessage: 'Laps to win should be greater than zero'
]

{ #category : #tests }
GameTest >> test003WhenSpaceshipsCompleteTwoLapsOnATwoLapCompletedGameThenTheSpaceshipWins [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aWormholeOne aWormholeTwo aPath aBoard aGame winner |
	aDie := LoadedDie of: 5.
	aDie add: (OrderedCollection with: 4 with: 3 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

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
	aBoard := Board createWith: aPath.

	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 2.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	winner := aGame checkWinnerOn: aBoard.

	self assert: winner id equals: 1
]

{ #category : #tests }
GameTest >> test006WhenASpaceshipIsOnSecondWormholeThenSpaceshipMovesToPositionOne [

	| spaceships aSpaceship anotherSpaceship aWormholeOne aWormholeTwo aBoxOne aPath aBoard aBoxTwo aBoxThree boxToCheck actualSpaceship |
	
	aSpaceship := Spaceship createWithId: 1.
	anotherSpaceship := Spaceship createWithId: 2.

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
	actualSpaceship := spaceships removeFirst.
	
	aSpaceship move: 2.
	boxToCheck := aBoard findBoxIn: (aSpaceship position).
	boxToCheck applyEffect: spaceships and: actualSpaceship.
	spaceships add: actualSpaceship.

	self assert: aSpaceship position equals: 1
]

{ #category : #tests }
GameTest >> test007WhenASpaceshipWinsThenPositionOfAnotherSpaceshipIsOne [

	| dices aDie cards aDeck aWormholeOne aWormholeTwo aBoxOne aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	aBoxOne := Box new.
	aPath := OrderedCollection
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxOne.
	aBoard := Board createWith: aPath.

	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 1)
]

{ #category : #tests }
GameTest >> test008WhenGameEndedThenReturnTheFinishSpaceshipPositionOnBoard [

	| dices aDie cards aDeck aWormholeOne aWormholeTwo aNormalBoxOne aPath aBoard aGame aNormalBoxTwo aNormalBoxThree |
	aDie := LoadedDie of: 5.
	aDie add: (OrderedCollection
			 with: 4
			 with: 3
			 with: 3
			 with: 3
			 with: 5).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

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

	aBoard := Board createWith: aPath.

	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 2.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 3)
]

{ #category : #tests }
GameTest >> test009WhenGameIsCreatedWithLessThanTwoSpaceshipsThenThrowError [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aPath aBoard |
	aDie := Die of: 4.
	dices := OrderedCollection with: aDie.
	
	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.

	aPath := OrderedCollection with: aNormalBoxOne with: aNormalBoxTwo.

	aBoard := Board createWith: aPath.

	cards := {
        1 -> Acceleration.
        2 -> Speed.
    } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	self
		should: [ Game createWithNumberOfSpaceships: 0 and: dices and: aDeck and: aBoard andLapsToWin: 1 ]
		raise: Error
		withMessage: 'Game should have a least two spaceships'
]

{ #category : #tests }
GameTest >> test010WhenGameIsCreatedWithoutDicesThenThrowError [

	| dices cards aDeck aNormalBoxOne aNormalBoxTwo aPath aBoard |

	dices := OrderedCollection new.
	
	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.

	aPath := OrderedCollection with: aNormalBoxOne with: aNormalBoxTwo.

	aBoard := Board createWith: aPath.
	
	cards := {
        1 -> Acceleration.
        2 -> Speed.
    } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	self
		should: [ Game createWithNumberOfSpaceships: 2 and: dices and: aDeck and: aBoard andLapsToWin: 1 ]
		raise: Error
		withMessage: 'Game should have a least one die'
]

{ #category : #tests }
GameTest >> test011WhenSpaceshipsMoveThreeBoxesThenASpaceshipWins [

	| dices aDie cards aDeck aWormholeOne aWormholeTwo aBoxOne aPath aBoard aGame winner |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	aBoxOne := Box new.
	aPath := OrderedCollection
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxOne.
	aBoard := Board createWith: aPath.

	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.

	winner := aGame checkWinnerOn: aBoard.

	self assert: winner id equals: 1
]

{ #category : #tests }
GameTest >> test014WhenSpaceshipMoveToAPositionWhereThereIsNotAnotherSpaceshipThenTheShieldIsNotAffected [

	| dices aDie cards aDeck aBoxOne aBoxTwo aBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 1).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

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

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.

	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 3 with: 3)
]

{ #category : #tests }
GameTest >> test015WhenTwoSpaceshipsBattleIfThereIsATieThenTheSecondSpaceshipLoseOneShieldAndRestartPositionOne [

	| dices aDie cards aDeck aBoxOne aBoxTwo aBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 1).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

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

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 1)
]

{ #category : #tests }
GameTest >> test016WhenBothSpaceshipsAreInPositionOneThenTheSpaceshipsAreNotAffectedThisIsASafeZone [

	| dices aDie cards aDeck aBoxOne aBoxTwo aBoxThree aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aBoxOne := NormalBox new.
	aBoxTwo := NormalBox new.
	aBoxThree := NormalBox new.

	aPath := OrderedCollection
		         with: aBoxOne
		         with: aBoxTwo
		         with: aBoxThree.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 1).

	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 3 with: 3)
]

{ #category : #tests }
GameTest >> test017WhenPassTurnThenTheSpaceshipRecoverAllShields [

	| dices aDie cards aDeck aBoxOne aBoxTwo aBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 1
			 with: 1
			 with: 2
			 with: 1
			 with: 2).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

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

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2).
	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 2 with: 3).

	aGame passTurn.

	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 3 with: 3)
]

{ #category : #tests }
GameTest >> test018WhenPassTurnThenTheSpaceshipStaysOnTheSamePlace [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 1
			 with: 3
			 with: 1
			 with: 1).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

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

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.
	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 1).
	aGame playTurn.
	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 3).
	aGame playTurn.
	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 3).
	aGame passTurn.
	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 3).
	aGame playTurn.
	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 5 with: 3)
]

{ #category : #tests }
GameTest >> test019CheckTheRankingOfSpaceshipsInTheGame [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 5.
	aDie add: (OrderedCollection
			 with: 1
			 with: 3
			 with: 2
			 with: 1
			 with: 5).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

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
	aBoard := Board createWith: aPath.

	aGame := Game
		         createWithNumberOfSpaceships: 3
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 2.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame checkRankingOn: aBoard)
		equals: (OrderedCollection with: 2 with: 3 with: 1)
]

{ #category : #tests }
GameTest >> test020CanNotBattleAfterASpaceshipHasWon [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 3)
]

{ #category : #tests }
GameTest >> test021WhenOnABattleTheSpaceshipsThrowTheSameThenTheOneWhichArrivedLastLose [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 2
			 with: 2
			 with: 3
			 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 1)
]

{ #category : #tests }
GameTest >> test022SpaceshipsStartWithTwoCardsWhenGameStarts [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 2
			 with: 2
			 with: 3
			 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 4
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection
				 with: 2
				 with: 2
				 with: 2
				 with: 2)
]

{ #category : #tests }
GameTest >> test023WhenGameStartsThenItHasNotPermanentCardsPlayed [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 2
			 with: 2
			 with: 3
			 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 4
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	self
		assert: aGame getPermanentCardPlayed
		equals: OrderedCollection new
]

{ #category : #tests }
GameTest >> test024WhenGameStartsThenThereIsNoLastCardPlay [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 2
			 with: 2
			 with: 3
			 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 4
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	self assert: aGame getLastCardPlayed isNil
]

{ #category : #tests }
GameTest >> test025WhenAnAccelerationCardIsPlayedThenAllThrowsIncreaseByOne [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Acceleration) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 1).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 4).

	self assert: aGame getPermanentCardPlayed size equals: 1
]

{ #category : #tests }
GameTest >> test026WhenAnSpeedCardIsPlayedThenTheAffectedSpaceshipThrowsIncreaseByOne [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 2.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 1).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 4).

	self assert: aGame getPermanentCardPlayed size equals: 1
]

{ #category : #tests }
GameTest >> test027WhenAnCancelationCardIsPlayedAndTheAffectedCardIsSpeedThenTheAffectedSpaceshipsDecreaseHisThrowByOne [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Speed).
		         (2 -> Cancellation) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 1).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 4).

	self assert: aGame getPermanentCardPlayed size equals: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 2.
	cardArguments at: 'idTargetCard' put: 1.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 0 with: 2).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 4).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 2).

	self assert: aGame getPermanentCardPlayed size equals: 0
]

{ #category : #tests }
GameTest >> test028WhenAnCancelationCardIsPlayedAndTheAffectedCardIsAccelerationThenAllSpaceshipsDecreaseHisThrowByOne [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Cancellation) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 1).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 5).

	self assert: aGame getPermanentCardPlayed size equals: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 2.
	cardArguments at: 'idTargetCard' put: 1.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 0 with: 2).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 5).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 3).

	self assert: aGame getPermanentCardPlayed size equals: 0
]

{ #category : #tests }
GameTest >> test029WhenAnMercenaryCardIsPlayedThenAlliedSpaceshipsNotFight [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Mercenary) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 3
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2 with: 2).

	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 2 with: 1)
]

{ #category : #tests }
GameTest >> test030WhenAMercenaryCardIsPlayedSpaceshipAndHisAlliedLoseThenLoseOneShieldBoth [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 1
			 with: 2
			 with: 1
			 with: 3
			 with: 1
			 with: 1).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Mercenary) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 3
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2 with: 2).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 3 with: 2).

	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 2 with: 2 with: 3)
]

{ #category : #tests }
GameTest >> test031WhenAnCancelationCardIsPlayedAndTheAffectedCardIsMercenaryThenTheAffectedSpaceshipLoseHisMercenary [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 1
			 with: 2
			 with: 1
			 with: 3
			 with: 1
			 with: 1).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Mercenary).
		         (2 -> Cancellation) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 3
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 4.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2 with: 2).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 3 with: 2).

	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 2 with: 2 with: 3).

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 4.
	cardArguments at: 'idTargetCard' put: 1.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 1 with: 2).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 1 with: 1).
	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 2 with: 2 with: 1)
]

{ #category : #tests }
GameTest >> test032WhenARepeatCardIsPlayAndLastBoxIsNormalBoxThenNoEffectApplied [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Repeat) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playTurn.
	aGame playTurn.
	aGame playCard: cardArguments.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
GameTest >> test033WhenARepeatCardIsPlayAndLastBoxIsBlackholeThenTheAffectedSpaceshipMoveFourBoxesBackwards [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aBlackHole aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 3 with: 5).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Repeat) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aBlackHole := BlackHole new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive
		         with: aBlackHole.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 3.
	cardArguments at: 'idTargetSpaceship' put: 1.

	aGame playTurn.
	aGame playTurn.
	aGame playCard: cardArguments.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2)
]

{ #category : #tests }
GameTest >> test034WhenARepeatCardIsPlayAndLastBoxIsHyperSpaceJumpThenTheAffectedSpaceshipMoveFourBoxesForwardAndLoseOneShield [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aHyperSpaceJump aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 2 with: 1).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Repeat) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aHyperSpaceJump := HyperSpaceJump new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aHyperSpaceJump
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 3.
	cardArguments at: 'idTargetSpaceship' put: 1.

	aGame playTurn.
	aGame playTurn.
	aGame playCard: cardArguments.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 6).

	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 2 with: 2)
]

{ #category : #tests }
GameTest >> test035WhenARepeatCardIsPlayAndLastBoxIsMoonWalkThenTheAffectedSpaceshipMoveTwoBoxesBackWards [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aMoonWalk aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 4 with: 3).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Repeat) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aMoonWalk := MoonWalk createWith: 2.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aMoonWalk
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 1.

	aGame playTurn.
	aGame playTurn.
	aGame playCard: cardArguments.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 2)
]

{ #category : #tests }
GameTest >> test036WhenARepeatCardIsPlayAndLastBoxIsAtomicbombThenAllSpaceshipLoseOneShieldAndReturnToPositionOne [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive anAtomicBomb aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 4 with: 3).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Repeat) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	anAtomicBomb := AtomicBomb new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: anAtomicBomb
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 1.

	aGame playTurn.
	aGame playTurn.
	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 1).
	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 2 with: 2).
	aGame playCard: cardArguments.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 1).
	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 1 with: 1)
]

{ #category : #tests }
GameTest >> test037WhenARepeatCardIsPlayAndLastBoxIsHyperJumpThenTheAffectedSpaceshipMovesFowardAnAmountOfParsecs [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aHyperJump aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 3 with: 1).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Repeat) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aHyperJump := LoadedHyperJump createWith: 3 andParsecsToBoxesRatio: 2.
	aHyperJump addParsecs: (OrderedCollection with: 6 with: 4 with: 3).
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aHyperJump
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 1.

	aGame playTurn.
	aGame playTurn.
	aGame playCard: cardArguments.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 6 with: 5)
]

{ #category : #tests }
GameTest >> test038WhenARedoCardIsPlayAndLastCardIsSpeedCardThenTheAffectedSpaceshipAddsOneToItsMove [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Speed).
		         (2 -> Redo) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playCard: cardArguments.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 2.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playCard: cardArguments.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 4)
]

{ #category : #tests }
GameTest >> test039WhenARedoCardIsPlayAndLastCardIsAccelerationCardThenAllSpaceshipAddOneToTheirMove [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Redo) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.


	aGame playCard: cardArguments.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 2.

	aGame playCard: cardArguments.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 5).

	self assert: aGame getPermanentCardPlayed size equals: 2
]

{ #category : #tests }
GameTest >> test040WhenARedoCardIsPlayAndLastCardIsCancellationCardThenRemoveTheCardSelected [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Redo).
		         (2 -> Speed).
		         (3 -> Cancellation).
		         (4 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 2.
	cardArguments at: 'idTargetSpaceship' put: 1.
	aGame playCard: cardArguments.

	aGame playTurn.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 4.
	cardArguments at: 'idTargetSpaceship' put: 2.
	aGame playCard: cardArguments.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 3.
	cardArguments at: 'idTargetCard' put: 2.
	aGame playCard: cardArguments.

	aGame playTurn.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetCard' put: 4.
	aGame playCard: cardArguments.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 5).

	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 3).

	self assert: aGame getPermanentCardPlayed size equals: 0
]

{ #category : #tests }
GameTest >> test041WhenARedoCardIsPlayAndLastCardIsRepeatCardThenSpaceshipTargetApplyTheLastBoxPlayed [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aBlackhole aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 3 with: 5).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Redo).
		         (2 -> Repeat) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aBlackhole := BlackHole new.

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive
		         with: aBlackhole.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 2).

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 4.
	cardArguments at: 'idTargetSpaceship' put: 1.
	aGame playCard: cardArguments.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 2.
	aGame playCard: cardArguments.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 1).

	self assert: aGame getPermanentCardPlayed size equals: 0
]

{ #category : #tests }
GameTest >> test042WhenARedoCardIsPlayAndLastCardIsMercenaryCardThenSpaceshipGetAMercenary [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Redo).
		         (2 -> Mercenary) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 3
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.


	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 2.
	cardArguments at: 'idTargetSpaceship' put: 2.
	aGame playCard: cardArguments.

	aGame playTurn.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 3.
	cardArguments at: 'idTargetSpaceship' put: 1.
	aGame playCard: cardArguments.

	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 2 with: 3).
	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 3 with: 3 with: 3).

	aGame playTurn.
	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 2 with: 1).
	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 3 with: 3 with: 2).

	self assert: aGame getPermanentCardPlayed size equals: 2
]

{ #category : #tests }
GameTest >> test043WhenASpaceshipIsInACardBoxThenGetsACard [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aCardBoxOne aCardBoxTwo aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2 with: 3).

	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Redo).
		         (2 -> Mercenary) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aCardBoxOne := CardBox createWith: aDeck.
	aCardBoxTwo := CardBox createWith: aDeck.

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aCardBoxOne
		         with: aNormalBoxTwo
		         with: aCardBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 3
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 3 with: 4).

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 3 with: 2 with: 3)
]
