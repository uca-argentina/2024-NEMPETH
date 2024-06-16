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
PathGeneratorTest >> test002VerifyCorrectDistributionsOfBoxes [

	| aPathGenerator pathOfTheBoard percent normalBoxes blackHoleBoxes hyperSpaceJumpBoxes 
	 moonwalkBoxes hyperJumpBoxes atomicBombBoxes |
	
	aPathGenerator := PathGenerator createWith: 7500 and: 5.
	
	pathOfTheBoard := aPathGenerator path.

	normalBoxes := pathOfTheBoard select: [ :box | box isKindOf: NormalBox ].
	percent := normalBoxes size/pathOfTheBoard size.
	
	self assert: ((percent) between:  0.35 and: 0.45).
	
	
	blackHoleBoxes := pathOfTheBoard select: [ :box | box isKindOf: BlackHole ].
	percent := blackHoleBoxes size/pathOfTheBoard size.
	
	self assert: ((percent) between: 0.15 and: 0.25).
	
	
	hyperSpaceJumpBoxes := pathOfTheBoard select: [ :box | box isKindOf: HyperSpaceJump ].
	percent := hyperSpaceJumpBoxes size/pathOfTheBoard size.
	
	self assert: ((percent) between: 0.15 and: 0.25).
	
	
	moonwalkBoxes := pathOfTheBoard select: [ :box | box isKindOf: MoonWalk ].
	percent := moonwalkBoxes size/pathOfTheBoard size.

	self assert: ((percent) between: 0.05 and: 0.15).
	
	hyperJumpBoxes := pathOfTheBoard select: [ :box | box isKindOf: HyperJump ].
	percent := hyperJumpBoxes size/pathOfTheBoard size.
	
	self assert: ((percent) between: 0.03 and: 0.12).

	atomicBombBoxes := pathOfTheBoard select: [ :box | box isKindOf: AtomicBomb ].
	percent := atomicBombBoxes size/pathOfTheBoard size.
	
	self assert: ((percent) between: 0 and: 0.07).


]

{ #category : #running }
PathGeneratorTest >> test003WhenRatioParsecToBoxesIsEqualOrLessThanZeroThenThorwError [
	
	self
		should: [ PathGenerator createWith: 50 and: 0. ]
		raise: Error
		withMessage: 'Parsec to boxes ratio should be greater that zero'
]
