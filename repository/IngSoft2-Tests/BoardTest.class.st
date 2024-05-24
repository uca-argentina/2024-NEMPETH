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
BoardTest >> testWhenBoardDoesNotHaveBoxesThenThrowError [

	|aPath|
	
	aPath := OrderedCollection new.
	
	self
		should: [ Board createWith: aPath. ]
		raise: Error
		withMessage: 'Path should have a least one box'
	
	
]

{ #category : #tests }
BoardTest >> testWhenBoardHasThreeBoxesThenLengthIsThree [

	|aBoard aPath aBox aWormhole anotherWormhole |
	
	aBox := Box new.
	aWormhole := Wormhole new.
	anotherWormhole := Wormhole new.
	aPath := OrderedCollection with: aBox with: aWormhole with: anotherWormhole.
	aBoard := Board createWith: aPath. 
	
	self assert: aBoard length equals: 3.
	
	
]

{ #category : #tests }
BoardTest >> testWhenBoardIsCreatedWithIncorrectNumberOfWormholesThenThrowError [
	|aPath aWormhole aBox anotherBox|
	
	aWormhole := Wormhole new.
	aBox := Box new.
	anotherBox := Box new.
	aPath := OrderedCollection with: aWormhole with: aBox with: anotherBox.
	
	self
		should: [ Board createWith: aPath. ]
		raise: Error
		withMessage: 'Path should have two boxes of Wormhole'

]

{ #category : #tests }
BoardTest >> testWhenBoardIsCreatedWithTwoBoxesAndWormholeThenLengthIsFour [

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
