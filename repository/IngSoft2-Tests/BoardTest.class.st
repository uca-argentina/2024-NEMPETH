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
BoardTest >> testBoardCreatedWithWormholeThenReturnThePositionOfWormhole [

	| aBoard |
	aBoard := Board withLength: 3 withWormholeOn: 1 and: 2.

	self assert: aBoard length equals: 3.
	self assert: aBoard wormholeStart equals: 1.
	self assert: aBoard wormholeEnd equals: 2.
]

{ #category : #tests }
BoardTest >> testWhenABoardIsCreatedWithLessThanOneBoxThenThrowError [

	self
		should: [ Board create: 0 ]
		raise: Error
		withMessage: 'Number of boxes should be greater than 0 (zero)'
]

{ #category : #tests }
BoardTest >> testWhenABoardIsCreatedWithOneBoxThenTheLenghtIsOne [

	| aBoard |
	aBoard := Board create: 1.

	self assert: aBoard length equals: 1
]

{ #category : #tests }
BoardTest >> testWhenABoardIsCreatedWithTenBoxesThenTheLenghtIsTen [

	| aBoard |
	aBoard := Board create: 10.

	self assert: aBoard length equals: 10
]

{ #category : #tests }
BoardTest >> testWhenABoardIsCreatedWithTwoBoxesThenTheLenghtIsTwo [

	| aBoard |
	aBoard := Board create: 2.

	self assert: aBoard length equals: 2
]

{ #category : #tests }
BoardTest >> testWhenBothWormholePositionsAreGreaterThanNumberOfBoxesThenThrowError [

	self
		should: [ Board withLength: 2 withWormholeOn: 3 and: 5 ]
		raise: Error
		withMessage: 'The wormhole should be inside the board'
]

{ #category : #tests }
BoardTest >> testWhenOneWormholePositionIsGreaterThanNumberOfBoxesThenThrowError [

	self
		should: [ Board withLength: 2 withWormholeOn: 1 and: 5 ]
		raise: Error
		withMessage: 'The wormhole should be inside the board'
]

{ #category : #tests }
BoardTest >> testWhenWormholeEndIsLessThanOneThenThrowError [

	self
		should: [ Board withLength: 3 withWormholeOn: 1 and: -1 ]
		raise: Error
		withMessage: 'Both positions of the wormhole should be greater than 0 (zero)'
]

{ #category : #tests }
BoardTest >> testWhenWormholeStartIsGreaterThanWormholeEndThenThrowError [

	self
		should: [ Board withLength: 3 withWormholeOn: 2 and: 1 ]
		raise: Error
		withMessage: 'The wormhole end should be greater than the wormhole start'
]

{ #category : #tests }
BoardTest >> testWhenWormholeStartIsLessThanOneThenThrowError [

	self
		should: [ Board withLength: 3 withWormholeOn: -1 and: 2 ]
		raise: Error
		withMessage: 'Both positions of the wormhole should be greater than 0 (zero)'
]
