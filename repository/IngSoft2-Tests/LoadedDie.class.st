Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'faces',
		'sequence',
		'index'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedDie class >> of: aNumberOfFaces [ 
	aNumberOfFaces < 3 ifTrue: [ Error signal: 'Faces should be more than 2' ].
	^ self new initializeOf: aNumberOfFaces.
]

{ #category : #adding }
LoadedDie >> add: aSequence [

	self sequenceValidation: aSequence.

	sequence := aSequence.
	index := 1
]

{ #category : #initialization }
LoadedDie >> initializeOf: aNumberOfFaces [
	faces := aNumberOfFaces.
]

{ #category : #adding }
LoadedDie >> sequenceValidation: aSequence [

	(aSequence anySatisfy: [ :each | each > faces ]) ifTrue: [
		Error signal:
			'Numbers in the sequence should be smaller than number of faces' ]
]

{ #category : #accessing }
LoadedDie >> throw [

	| number |
	number := sequence at: index.
	index = sequence size ifTrue: [ index := index - sequence size ].

	index := index + 1.
	^ number
]
