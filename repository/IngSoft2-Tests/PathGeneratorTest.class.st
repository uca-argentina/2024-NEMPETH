Class {
	#name : #PathGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
	
	aPathGenerator := PathGenerator createWith: 10000 and: 5.
	
	pathOfTheBoard := aPathGenerator path.

	normalBoxes := pathOfTheBoard select: [ :box | box isKindOf: NormalBox ].
	percent := normalBoxes size/pathOfTheBoard size.
	
	self assert: ((percent) between: 0.37 and: 0.43).
	
	
	blackHoleBoxes := pathOfTheBoard select: [ :box | box isKindOf: BlackHole ].
	percent := blackHoleBoxes size/pathOfTheBoard size.
	
	self assert: ((percent) between: 0.18 and: 0.22).
	
	
	hyperSpaceJumpBoxes := pathOfTheBoard select: [ :box | box isKindOf: HyperSpaceJump ].
	percent := hyperSpaceJumpBoxes size/pathOfTheBoard size.
	
	self assert: ((percent) between: 0.18 and: 0.22).
	
	
	moonwalkBoxes := pathOfTheBoard select: [ :box | box isKindOf: MoonWalk ].
	percent := moonwalkBoxes size/pathOfTheBoard size.

	self assert: ((percent) between: 0.08 and: 0.12).
	
	hyperJumpBoxes := pathOfTheBoard select: [ :box | box isKindOf: HyperJump ].
	percent := hyperJumpBoxes size/pathOfTheBoard size.
	
	self assert: ((percent) between: 0.06 and: 0.10).

	atomicBombBoxes := pathOfTheBoard select: [ :box | box isKindOf: AtomicBomb ].
	percent := atomicBombBoxes size/pathOfTheBoard size.
	
	self assert: ((percent) between: 0.01 and: 0.03).


]
