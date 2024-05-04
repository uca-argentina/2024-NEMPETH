Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfBoxes',
		'wormholeStart',
		'wormholeEnd'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> create: aNumberOfBoxes [ 
	aNumberOfBoxes < 1 ifTrue: [ Error signal: 'Number of boxes should be greater than 0 (zero)' ].
	^ self new initializeWith: aNumberOfBoxes.
]

{ #category : #'instance creation' }
Board class >> create: aNumberOfBoxes withWormholeOn: aWormholeStart and: aWormholeEnd [
	aNumberOfBoxes < 1 ifTrue: [ Error signal: 'Number of boxes should be greater than 0 (zero)' ].
	aWormholeStart < 1 ifTrue: [ Error signal: 'Both positions of the wormhole should be greater than 0 (zero)' ].
	aWormholeEnd < 1 ifTrue: [ Error signal: 'Both positions of the wormhole should be greater than 0 (zero)' ].
	^ self new initializeWith: aNumberOfBoxes initializeWithWormholeOn: aWormholeStart and: aWormholeEnd 
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfBoxes [
	numberOfBoxes := aNumberOfBoxes.
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfBoxes initializeWithWormholeOn: aWormholeStart and: aWormholeEnd [ 
	numberOfBoxes := aNumberOfBoxes.
	wormholeStart := aWormholeStart.
	wormholeEnd := aWormholeEnd.	
]

{ #category : #accessing }
Board >> length [
	^ numberOfBoxes.
]

{ #category : #accessing }
Board >> wormholeEnd [
	^ wormholeEnd
]

{ #category : #accessing }
Board >> wormholeStart [
	^ wormholeStart
]
