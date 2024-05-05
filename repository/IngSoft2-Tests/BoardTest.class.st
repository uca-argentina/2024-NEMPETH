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
BoardTest >> testBanana [

	|aBoard aPath aWormhole anotherWormhole aBox anotherBox|
	
	aWormhole := Wormhole new.
	anotherWormhole := Wormhole new.
	aBox := Box new.
	anotherBox := Box new.
	aPath := OrderedCollection with: aWormhole with: aBox with: anotherWormhole with: anotherBox.
	aBoard := Board createWith: aPath. 
	
	self assert: aBoard length equals: 4.
	
	
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
BoardTest >> testWhenBoardHasOneBoxThenLengthIsOne [

	|aBoard aPath aBox|
	
	aBox := Box new.
	aPath := OrderedCollection with: aBox.
	aBoard := Board createWith: aPath. 
	
	self assert: aBoard length equals: 1.
	
	
]

{ #category : #tests }
BoardTest >> testWhenBoardHasTwoBoxThenLengthIsTwo [

	|aBoard aPath aBox anotherBox|
	
	aBox := Box new.
	anotherBox := Box new.
	aPath := OrderedCollection with: aBox with: anotherBox.
	aBoard := Board createWith: aPath. 
	
	self assert: aBoard length equals: 2.
	
	
]

{ #category : #tests }
BoardTest >> testWhenBoardIsCreatedWithTwoBoxesAndWormholeThenLengthIsFour [

	|aBoard aPath aWormhole anotherWormhole aBox anotherBox|
	
	aWormhole := Wormhole new.
	anotherWormhole := Wormhole new.
	aBox := Box new.
	anotherBox := Box new.
	aPath := OrderedCollection with: aWormhole with: aBox with: anotherWormhole with: anotherBox.
	aBoard := Board createWith: aPath. 
	
	self assert: aBoard length equals: 4.
	
	
]

{ #category : #tests }
BoardTest >> testWhenBoardIsCreatedWithWormholeThenLengthIsTwo [

	|aBoard aPath aWormhole anotherWormhole|
	
	aWormhole := Wormhole new.
	anotherWormhole := Wormhole new.
	aPath := OrderedCollection with: aWormhole with: anotherWormhole.
	aBoard := Board createWith: aPath. 
	
	self assert: aBoard length equals: 2.
	
	
]
