Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testWhenAGameEndsReturnTrue [

	| aGame |
	aGame := Game new.
	
	self assert: aGame end.
]

{ #category : #tests }
GameTest >> testWhenAGameStartsReturnTrue [

	| aGame |
	aGame := Game new.
	
	self assert: aGame start.
]
