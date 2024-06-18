Class {
	#name : #Unit,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Unit class >> createWith: aValue [ 
	^ self new initializeWith: aValue
]

{ #category : #'as yet unclassified' }
Unit >> initializeWith: aValue [ 
	value := aValue.
]

{ #category : #'as yet unclassified' }
Unit >> toParsec [
	^ self subclassResponsibility
]
