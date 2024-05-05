Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'path'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> createWith: aPath [

	self pathValidation: aPath.

	self wormholeValidation: aPath.

	^ self new initializeWith: aPath
]

{ #category : #'instance creation' }
Board class >> pathValidation: aPath [

	aPath size < 1 ifTrue: [
		Error signal: 'Path should have a least one box' ]
]

{ #category : #'instance creation' }
Board class >> wormholeValidation: aPath [

	| wormholeCounter |
	
	wormholeCounter := 0.
	aPath do: [ :aBox |
		(aBox isKindOf: Wormhole) ifTrue: [
			wormholeCounter := wormholeCounter + 1 ] ].

	wormholeCounter ~= 2 ifTrue: [
		Error signal: 'Path should have two boxes of Wormhole' ].
]

{ #category : #initialization }
Board >> initializeWith: aPath [ 
	
	path := aPath.
]

{ #category : #accessing }
Board >> length [
	
	^ path size.
]

{ #category : #'as yet unclassified' }
Board >> verifyBoxOf: aSpaceship [

	| positionToMove |
	positionToMove := 0.

	((path at: aSpaceship position) isKindOf: Wormhole) ifTrue: [
		path withIndexDo: [ :box :index |
			(box isKindOf: Wormhole) & (aSpaceship position ~= index) ifTrue: [
				positionToMove := index - aSpaceship position ] ] ].

	aSpaceship move: positionToMove
]
