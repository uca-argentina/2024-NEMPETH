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

	self verifyPositiveNumberOfBoxes: aNumberOfBoxes.
	^ self new initializeWith: aNumberOfBoxes
]

{ #category : #'instance creation' }
Board class >> verify: aWormholeStart and: aWormholeEnd isIn: aNumberOfBoxes [

	(aWormholeStart > aNumberOfBoxes or: [ aWormholeEnd > aNumberOfBoxes ])
		ifTrue: [ Error signal: 'The wormhole should be inside the board' ]
]

{ #category : #'instance creation' }
Board class >> verify: aWormholeStart isGreaterThan: aWormholeEnd [

	aWormholeEnd < aWormholeStart ifTrue: [
		Error signal:
			'The wormhole end should be greater than the wormhole start' ]
]

{ #category : #'instance creation' }
Board class >> verifyNotNegativePositionOfWormhole: aWormholeStart and: aWormholeEnd [

	(aWormholeStart < 1 or: [ aWormholeEnd < 1 ]) ifTrue: [
		Error signal:
			'Both positions of the wormhole should be greater than 0 (zero)' ]
]

{ #category : #'instance creation' }
Board class >> verifyPositiveNumberOfBoxes: aNumberOfBoxes [

	aNumberOfBoxes < 1 ifTrue: [
		Error signal: 'Number of boxes should be greater than 0 (zero)' ]
]

{ #category : #'instance creation' }
Board class >> withLength: aNumberOfBoxes withWormholeOn: aWormholeStart and: aWormholeEnd [

	self verifyPositiveNumberOfBoxes: aNumberOfBoxes.
	self
		verifyNotNegativePositionOfWormhole: aWormholeStart
		and: aWormholeEnd.
	self
		verify: aWormholeStart
		and: aWormholeEnd
		isIn: aNumberOfBoxes.
	self verify: aWormholeStart isGreaterThan: aWormholeEnd.
	^ self new
		  initializeWith: aNumberOfBoxes
		  initializeWithWormholeOn: aWormholeStart
		  and: aWormholeEnd
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
