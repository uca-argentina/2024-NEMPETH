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

	(aPath size < 1) 
		ifTrue: [ Error signal: 'Path should have a least one box' ].
		 
	^ self new initializeWith: aPath.
]

{ #category : #initialization }
Board >> initializeWith: aPath [ 
	
	path := aPath.
]

{ #category : #accessing }
Board >> length [
	
	^ path size.
]
