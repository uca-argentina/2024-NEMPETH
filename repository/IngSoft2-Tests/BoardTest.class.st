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
		should: [ Board createWith: aPath. ]
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
	aBoard := Board createWith: aPath .
	
	self assert: (aBoard length) equals: 3.
	
	
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
	aBoard := Board createWith: aPath.
	
	self assert: aBoard length equals: 4.
	self assert: (aPath at: 1) position equals: 1.
]

{ #category : #tests }
BoardTest >> test005ForLoadedBoardWhenASpaceshipPassTheLastBoxThenAddALapCompletedToSpaceship [

	| aSpaceship aBoard aPath aWormhole anotherWormhole aBox anotherBox |
	aSpaceship := Spaceship createWithId: 1.

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
	aBoard := Board createWith: aPath.
	
	aSpaceship move: 6.
		
	aBoard normalizeOne: aSpaceship.
	
	self assert: aSpaceship position equals: 3. 
	self assert: aSpaceship lapsCompleted equals: 1.

]

{ #category : #tests }
BoardTest >> test006ForLoadedBoardWhenASpaceshipPassTheLastBoxAndAnotherSpaceshipDoesNotThenAddALapToASpaceship [
	| aSpaceship anotherSpaceship spaceships aBoard aPath aWormhole anotherWormhole aBox anotherBox |
	aSpaceship := Spaceship createWithId: 1.
	anotherSpaceship := Spaceship createWithId: 2.

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
	aBoard := Board createWith: aPath.
	
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
	aSpaceship := Spaceship createWithId: 1.
	anotherSpaceship := Spaceship createWithId: 2.

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
	aBoard := Board createWith: aPath.
	
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
	aSpaceship := Spaceship createWithId: 1.
	anotherSpaceship := Spaceship createWithId: 2.

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
	aBoard := Board createWith: aPath.
	
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
BoardTest >> test010TheFirstBoxOfTheBoardIsANormalBox [

	| aBoard aPathGenerator|
	
	aPathGenerator := PathGenerator createWith: 10 and: 5. 
	
	aBoard := Board createWith: aPathGenerator path.

	self assert: ((aBoard findBoxIn: 1 ) isKindOf: NormalBox)
]

{ #category : #tests }
BoardTest >> test013ForBoardWhenASpaceshipPassTheLastBoxThenAddALapCompletedToSpaceship [

		| aSpaceship aBoard aPath|
		
	aSpaceship := Spaceship createWithId: 2.
	aPath := OrderedCollection with: NormalBox new with: NormalBox new with: NormalBox new.

	aBoard := Board createWith: aPath.
	
	aSpaceship move: 3.
		
	aBoard normalizeOne: aSpaceship.
	
	self assert: aSpaceship position equals: 1. 
	self assert: aSpaceship lapsCompleted equals: 1.
]

{ #category : #tests }
BoardTest >> test014ForBoardWhenASpaceshipPassTheLastBoxAndAnotherSpaceshipDoesNotThenAddALapToASpaceship [
	| aSpaceship anotherSpaceship spaceships aBoard aPath |
	
	aSpaceship := Spaceship createWithId: 1.
	anotherSpaceship := Spaceship createWithId: 2.
	aPath := OrderedCollection with: NormalBox new with: NormalBox new with: NormalBox new.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.
		
	aBoard := Board createWith: aPath.
	
	aSpaceship move: 3.
		
	aBoard normalizeAll: spaceships.
	
	self assert: aSpaceship position equals: 1. 
	self assert: aSpaceship lapsCompleted equals: 1.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship lapsCompleted equals: 0.
]

{ #category : #tests }
BoardTest >> test015ForBoardCanNotGoBackBeyondFirstBoxOnFirstLap [
	| aSpaceship anotherSpaceship spaceships aBoard aPath |
	
	aSpaceship := Spaceship createWithId: 1.
	anotherSpaceship := Spaceship createWithId: 2.
	aPath := OrderedCollection with: NormalBox new with: NormalBox new with: NormalBox new.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.
		
	aBoard := Board createWith: aPath.
	
	aSpaceship move: 3.
	anotherSpaceship move: -3.
		
	aBoard normalizeAll: spaceships.
	
	self assert: aSpaceship position equals: 1. 
	self assert: aSpaceship lapsCompleted equals: 1.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship lapsCompleted equals: 0.
]

{ #category : #tests }
BoardTest >> test016ForBoardWhenASpaceshipMovesBackThroughFirstBoxThenSubtractOneLapCompleted [
	| aSpaceship anotherSpaceship spaceships aBoard aPath |
	
	aSpaceship := Spaceship createWithId: 1.
	anotherSpaceship := Spaceship createWithId: 2.
	aPath := OrderedCollection with: NormalBox new with: NormalBox new with: NormalBox new.
	
	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.
		
	aBoard := Board createWith: aPath.
	
	aSpaceship move: 3.
		
	aBoard normalizeAll: spaceships.
	
	self assert: aSpaceship position equals: 1. 
	self assert: aSpaceship lapsCompleted equals: 1.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship lapsCompleted equals: 0.
	
	aSpaceship move: -3.
		
	aBoard normalizeAll: spaceships.
	
	self assert: aSpaceship position equals: 1. 
	self assert: aSpaceship lapsCompleted equals: 0.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship lapsCompleted equals: 0.
]
