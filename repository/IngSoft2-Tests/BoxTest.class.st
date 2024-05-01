Class {
	#name : #BoxTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoxTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: anErrorBlock raise: anErrorClass withExceptionDo: [ :error | self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
BoxTest >> testBanana [

	self should: [ Box on: -1 ] raise: Error withMessage: 'Position should be positive'.
]

{ #category : #tests }
BoxTest >> testWhenABoxIsInPositionZeroThenReturnZero [

	| aBox |
	aBox := Box on: 0.
	
	self assert: aBox position equals: 0.
]
