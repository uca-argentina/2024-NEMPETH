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