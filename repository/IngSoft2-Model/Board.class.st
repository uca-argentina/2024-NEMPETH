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
		(aBox isWormhole) ifTrue: [
			wormholeCounter := wormholeCounter + 1 ] ].

	wormholeCounter ~= 2 ifTrue: [
		Error signal: 'Path should have two boxes of Wormhole' ]
]

{ #category : #'as yet unclassified' }
Board >> findBoxIn: aPosition [

	^ path at: aPosition
]

{ #category : #initialization }
Board >> initializeWith: aPath [

	path := aPath.

	path withIndexDo: [ :box :index | box position: index ]
]

{ #category : #accessing }
Board >> length [
	
	^ path size.
]

{ #category : #private }
Board >> normalize: aSpaceship [

	aSpaceship position > self length ifFalse: [ ^ self ].
	aSpaceship move: -1 * self length.
	aSpaceship addLap
]
