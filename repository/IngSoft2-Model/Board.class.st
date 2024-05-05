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

	| wormholeCounter |
	
	aPath size < 1 ifTrue: [
		Error signal: 'Path should have a least one box' ].
	
	wormholeCounter := 0.
	aPath do: [ :aBox |
		(aBox isKindOf: Wormhole) ifTrue: [
			wormholeCounter := wormholeCounter + 1 ] ].

	wormholeCounter ~= 2 ifTrue: [
		Error signal: 'Path should have two boxes of Wormhole' ].

	^ self new initializeWith: aPath
]

{ #category : #initialization }
Board >> initializeWith: aPath [ 
	
	path := aPath.
]

{ #category : #accessing }
Board >> length [
	
	^ path size.
]
