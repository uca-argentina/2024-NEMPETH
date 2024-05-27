Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: anErrorBlock raise: anErrorClass withExceptionDo: [ :error | self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
BoardTest >> test001WhenBoardDoesNotHaveBoxesThenThrowError [

	|aPath|
	
	aPath := OrderedCollection new.
	
	self
		should: [ LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2. ]
		raise: Error
		withMessage: 'Path should have a least one box'
	
	
]

{ #category : #tests }
BoardTest >> test002WhenBoardHasThreeBoxesThenLengthIsThree [

	|aBoard aPath aBox aWormhole anotherWormhole |
	
	aBox := Box new.
	aWormhole := Wormhole new.
	anotherWormhole := Wormhole new.
	aPath := OrderedCollection with: aBox with: aWormhole with: anotherWormhole.
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2. 
	
	self assert: aBoard length equals: 3.
	
	
]

{ #category : #tests }
BoardTest >> test004WhenBoardIsCreatedWithTwoBoxesAndWormholeThenLengthIsFour [

	|aBoard aPath aWormhole anotherWormhole aBox anotherBox|
	
	aWormhole := Wormhole new.
	anotherWormhole := Wormhole new.
	
	aWormhole associateWith: anotherWormhole.
	anotherWormhole associateWith: aWormhole.
	
	aBox := Box new.
	anotherBox := Box new.
	aPath := OrderedCollection with: aWormhole with: aBox with: anotherWormhole with: anotherBox.
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2. 
	
	self assert: aBoard length equals: 4.
	self assert: (aPath at: 1) position equals: 1.
]

{ #category : #tests }
BoardTest >> test005ForLoadedBoardWhenASpaceshipPassTheLastBoxThenAddALapCompletedToSpaceship [

	| aSpaceship aBoard aPath aWormhole anotherWormhole aBox anotherBox |
	aSpaceship := Spaceship create.

	aWormhole := Wormhole new.
	anotherWormhole := Wormhole new.

	aWormhole associateWith: anotherWormhole.
	anotherWormhole associateWith: aWormhole.

	aBox := Box new.
	anotherBox := Box new.
	aPath := OrderedCollection
		         with: aWormhole
		         with: aBox
		         with: anotherWormhole
		         with: anotherBox.
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	
	aSpaceship move: 6.
		
	aBoard normalizeOne: aSpaceship.
	
	self assert: aSpaceship position equals: 3. 
	self assert: aSpaceship lapsCompleted equals: 1.

]

{ #category : #tests }
BoardTest >> test006ForLoadedBoardWhenASpaceshipPassTheLastBoxAndAnotherSpaceshipDoesNotThenAddALapToASpaceship [
	| aSpaceship anotherSpaceship spaceships aBoard aPath aWormhole anotherWormhole aBox anotherBox |
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.

	aWormhole := Wormhole new.
	anotherWormhole := Wormhole new.

	aWormhole associateWith: anotherWormhole.
	anotherWormhole associateWith: aWormhole.

	aBox := Box new.
	anotherBox := Box new.
	aPath := OrderedCollection
		         with: aWormhole
		         with: aBox
		         with: anotherWormhole
		         with: anotherBox.
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	
	aSpaceship move: 6.
	anotherSpaceship move: 3.
		
	aBoard normalizeAll: spaceships.
	
	self assert: aSpaceship position equals: 3. 
	self assert: aSpaceship lapsCompleted equals: 1.
	self assert: anotherSpaceship position equals: 4.
	self assert: anotherSpaceship lapsCompleted equals: 0.

]

{ #category : #tests }
BoardTest >> test007ForLoadedBoardCanNotGoBackBeyondFirstBoxOnFirstLap [
	| aSpaceship anotherSpaceship spaceships aBoard aPath aWormhole anotherWormhole aBox anotherBox |
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.

	aWormhole := Wormhole new.
	anotherWormhole := Wormhole new.

	aWormhole associateWith: anotherWormhole.
	anotherWormhole associateWith: aWormhole.

	aBox := Box new.
	anotherBox := Box new.
	aPath := OrderedCollection
		         with: aWormhole
		         with: aBox
		         with: anotherWormhole
		         with: anotherBox.
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	
	aSpaceship move: 6.
	anotherSpaceship move: -3.
		
	aBoard normalizeAll: spaceships.
	
	self assert: aSpaceship position equals: 3. 
	self assert: aSpaceship lapsCompleted equals: 1.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship lapsCompleted equals: 0.

]

{ #category : #tests }
BoardTest >> test008ForLoaded8WhenASpaceshipMovesBackThroughFirstBoxThenSubtractOneLapCompleted [
	| aSpaceship anotherSpaceship spaceships aBoard aPath aWormhole anotherWormhole aBox anotherBox |
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.

	aWormhole := Wormhole new.
	anotherWormhole := Wormhole new.

	aWormhole associateWith: anotherWormhole.
	anotherWormhole associateWith: aWormhole.

	aBox := Box new.
	anotherBox := Box new.
	aPath := OrderedCollection
		         with: aWormhole
		         with: aBox
		         with: anotherWormhole
		         with: anotherBox.
	aBoard := LoadedBoard createWith: aPath andParsecsToBoxesRatio: 2.
	
	aSpaceship move: 6.
	anotherSpaceship move: 1.
		
	aBoard normalizeAll: spaceships.
	
	self assert: aSpaceship position equals: 3. 
	self assert: aSpaceship lapsCompleted equals: 1.
	self assert: anotherSpaceship position equals: 2.
	self assert: anotherSpaceship lapsCompleted equals: 0.
	
	aSpaceship move: -3.
	anotherSpaceship move: -3.
		
	aBoard normalizeAll: spaceships.
	
	self assert: aSpaceship position equals: 4. 
	self assert: aSpaceship lapsCompleted equals: 0.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship lapsCompleted equals: 0.

]

{ #category : #tests }
BoardTest >> test009CheckLengthWhenBoardIsCreated [
	| aBoard |
	aBoard := Board createWith: 50.

	self assert: aBoard length equals: 50.
]

{ #category : #tests }
BoardTest >> test010TheFirstBoxOfTheBoardIsANormalBox [

	| aBoard |
	aBoard := Board createWith: 50.

	self assert: ((aBoard findBoxIn: 1 ) isKindOf: NormalBox)
]

{ #category : #tests }
BoardTest >> test011VerifyCorrectDistributionsOfBoxes [

	| aBoard pathOfTheBoard normalBoxes hyperSpaceJumpBoxes moonwalkBoxes hyperJumpBoxes atomicBombBoxes wormHolesBoxes blackHoleBoxes |
	aBoard := Board createWith: 50.
	pathOfTheBoard := aBoard path.

	normalBoxes := pathOfTheBoard select: [ :box |
		               box isKindOf: NormalBox ].

	self assert: normalBoxes size equals: (aBoard length * 0.4 - 2).


	hyperSpaceJumpBoxes := pathOfTheBoard select: [ :box |
		                       box isKindOf: HyperSpaceJump ].

	self assert: hyperSpaceJumpBoxes size equals: aBoard length * 0.2.


	moonwalkBoxes := pathOfTheBoard select: [ :box |
		                 box isKindOf: MoonWalk ].

	self assert: moonwalkBoxes size equals: aBoard length * 0.1.

	hyperJumpBoxes := pathOfTheBoard select: [ :box |
		                  box isKindOf: HyperJump ].

	self assert: hyperJumpBoxes size equals: aBoard length * 0.08.


	atomicBombBoxes := pathOfTheBoard select: [ :box |
		                   box isKindOf: AtomicBomb ].

	self assert: atomicBombBoxes size equals: aBoard length * 0.02.

	wormHolesBoxes := pathOfTheBoard select: [ :box |
		                  box isKindOf: Wormhole ].

	self assert: wormHolesBoxes size equals: 2.
	
	blackHoleBoxes := pathOfTheBoard select: [ :box |
		                  box isKindOf: BlackHole  ].

	self assert: blackHoleBoxes size equals: aBoard length * 0.2.
]

{ #category : #tests }
BoardTest >> test012WhenBoardIsCreatedWithIncorrectNumberOfBoxesThenThrowError [

	self
		should: [ Board createWith: -30 ]
		raise: Error
		withMessage:
		'Board length should be multiple of 50 and greater than 0'
]

{ #category : #tests }
BoardTest >> test013ForBoardWhenASpaceshipPassTheLastBoxThenAddALapCompletedToSpaceship [

		| aSpaceship aBoard |
		
	aSpaceship := Spaceship create.

	aBoard := Board createWith: 50.
	
	aSpaceship move: 50.
		
	aBoard normalizeOne: aSpaceship.
	
	self assert: aSpaceship position equals: 1. 
	self assert: aSpaceship lapsCompleted equals: 1.
]

{ #category : #tests }
BoardTest >> test014ForBoardWhenASpaceshipPassTheLastBoxAndAnotherSpaceshipDoesNotThenAddALapToASpaceship [
	| aSpaceship anotherSpaceship spaceships aBoard |
	
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.
		
	aBoard := Board createWith: 50.
	
	aSpaceship move: 50.
		
	aBoard normalizeAll: spaceships.
	
	self assert: aSpaceship position equals: 1. 
	self assert: aSpaceship lapsCompleted equals: 1.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship lapsCompleted equals: 0.
]

{ #category : #tests }
BoardTest >> test015ForBoardCanNotGoBackBeyondFirstBoxOnFirstLap [
	| aSpaceship anotherSpaceship spaceships aBoard |
	
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.
		
	aBoard := Board createWith: 50.
	
	aSpaceship move: 50.
	anotherSpaceship move: -3.
		
	aBoard normalizeAll: spaceships.
	
	self assert: aSpaceship position equals: 1. 
	self assert: aSpaceship lapsCompleted equals: 1.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship lapsCompleted equals: 0.
]

{ #category : #tests }
BoardTest >> test016ForBoardWhenASpaceshipMovesBackThroughFirstBoxThenSubtractOneLapCompleted [
	| aSpaceship anotherSpaceship spaceships aBoard |
	
	aSpaceship := Spaceship create.
	anotherSpaceship := Spaceship create.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.
		
	aBoard := Board createWith: 50.
	
	aSpaceship move: 50.
		
	aBoard normalizeAll: spaceships.
	
	self assert: aSpaceship position equals: 1. 
	self assert: aSpaceship lapsCompleted equals: 1.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship lapsCompleted equals: 0.
	
	aSpaceship move: -50.
		
	aBoard normalizeAll: spaceships.
	
	self assert: aSpaceship position equals: 1. 
	self assert: aSpaceship lapsCompleted equals: 0.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship lapsCompleted equals: 0.
]
