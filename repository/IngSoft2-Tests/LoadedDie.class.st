Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'position',
		'faces'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedDie class >> of: aNumberOfFaces [ 
	aNumberOfFaces < 3 ifTrue: [ Error signal: 'Faces should be more than 2' ].
	^ self new initializeOf: aNumberOfFaces.
]

{ #category : #initialization }
LoadedDie >> initializeOf: aNumberOfFaces [
	faces := aNumberOfFaces.
]

{ #category : #accessing }
LoadedDie >> throw [
	^ faces.
]
