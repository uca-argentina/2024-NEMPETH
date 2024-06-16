Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DieTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: anErrorBlock raise: anErrorClass withExceptionDo: [ :error | self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
DieTest >> testWhenDieIsCreatedWithFiveFacesThenThrowReturnBetweenOneAndFive [

	| aDie |
	aDie := Die of: 5.

	self assert: ((aDie throw) between: 1 and: 5)
]

{ #category : #tests }
DieTest >> testWhenDieIsCreatedWithThreeFacesThenThrowReturnBetweenOneAndThree [

	| aDie |
	aDie := Die of: 3.

	self assert: ((aDie throw) between: 1 and: 3)
]

{ #category : #tests }
DieTest >> testWhenDieIsCreatedWithTwoFacesThenThrowError [

	self
		should: [ Die of: 2 ]
		raise: Error
		withMessage: 'Faces should be more than 2'
]
