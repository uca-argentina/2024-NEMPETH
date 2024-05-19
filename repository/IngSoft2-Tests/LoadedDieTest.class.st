Class {
	#name : #LoadedDieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
LoadedDieTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: anErrorBlock raise: anErrorClass withExceptionDo: [ :error | self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
LoadedDieTest >> testWhenDieIsCreatedWithFiveFacesThenThrowReturnFive [

	| aLoadedDie |
	aLoadedDie := LoadedDie of: 5.

	self assert: aLoadedDie throw equals: 5
]

{ #category : #tests }
LoadedDieTest >> testWhenDieIsCreatedWithThreeFacesThenThrowReturnThree [

	| aLoadedDie |
	aLoadedDie := LoadedDie of: 3.

	self assert: aLoadedDie throw equals: 3
]

{ #category : #tests }
LoadedDieTest >> testWhenDieIsCreatedWithTwoFacesThenThrowError [

	self
		should: [ LoadedDie of: 2 ]
		raise: Error
		withMessage: 'Faces should be more than 2'
]
