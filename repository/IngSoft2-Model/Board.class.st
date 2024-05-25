Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'path'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> createWith: aLength [

	^self new initializeWith: aLength.
]

{ #category : #initialization }
Board >> initializeWith: aLength [
	
	path := OrderedCollection new.
	
	1 to: aLength do: [ :i | path add: (Box new) ].
]

{ #category : #accessing }
Board >> length [
	^ path size.
]
