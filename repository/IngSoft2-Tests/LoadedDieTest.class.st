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
LoadedDieTest >> test001WhenDieIsCreatedWithThreeFacesAndACollectionOfNumbersIsAddedThenWhenThrowReturnTheNumbersInTheCollection [

	| aLoadedDie aSequence |
	aLoadedDie := LoadedDie of: 3.

	aSequence := OrderedCollection with: 1 with: 2 with: 3 with: 2.
	aLoadedDie add: aSequence.

	self assert: aLoadedDie throw equals: 1.
	self assert: aLoadedDie throw equals: 2.
	self assert: aLoadedDie throw equals: 3.
	self assert: aLoadedDie throw equals: 2.
	self assert: aLoadedDie throw equals: 1.
	self assert: aLoadedDie throw equals: 2.
	self assert: aLoadedDie throw equals: 3.
]

{ #category : #tests }
LoadedDieTest >> test002WhenDieIsCreatedWithThreeFacesAndTheCollectionOfNumbersHasANumberGreaterThanNumberOfFacesThenThrowError [
	| aLoadedDie aSequence |
	aLoadedDie := LoadedDie of: 3.

	aSequence := OrderedCollection with: 1 with: 2 with: 4 with: 2.
	
	self
		should: [ aLoadedDie add: aSequence ]
		raise: Error
		withMessage: 'Numbers in the sequence should be smaller than number of faces'
]

{ #category : #tests }
LoadedDieTest >> testWhenDieIsCreatedWithTwoFacesThenThrowError [

	self
		should: [ LoadedDie of: 2 ]
		raise: Error
		withMessage: 'Faces should be more than 2'
]
