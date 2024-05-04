Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Die class >> of: aNumberOfFaces [ 
	aNumberOfFaces < 3 ifTrue: [ Error signal: 'Faces should be more than 2' ].
	^ self new initializeOf: aNumberOfFaces.
]

{ #category : #initialization }
Die >> initializeOf: aNumberOfFaces [
	faces := aNumberOfFaces.
]

{ #category : #accessing }
Die >> throw [
	^ faces atRandom. 
]
