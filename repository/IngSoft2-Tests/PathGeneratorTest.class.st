Class {
	#name : #PathGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
PathGeneratorTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: anErrorBlock raise: anErrorClass withExceptionDo: [ :error | self assert: error messageText equals: anErrorMessage ]
]

{ #category : #running }
PathGeneratorTest >> test001WhenPathIsCreateThenTheFisrtBoxisKindOfNormalBox [

	| aPathGenerator |
	aPathGenerator := PathGenerator createWith: 10 and: 5.
	
	self assert: (((aPathGenerator path) at: 1) isKindOf: NormalBox).
]

{ #category : #running }
PathGeneratorTest >> test003WhenRatioParsecToBoxesIsEqualOrLessThanZeroThenThorwError [
	
	self
		should: [ PathGenerator createWith: 50 and: 0. ]
		raise: Error
		withMessage: 'Parsec to boxes ratio should be greater that zero'
]
