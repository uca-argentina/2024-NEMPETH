Class {
	#name : #LoadedBoard,
	#superclass : #Object,
	#instVars : [
		'path',
		'parsecsToBoxesRatio'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedBoard class >> createWith: aPath andParsecsToBoxesRatio: aRatio [

	self pathValidation: aPath.

	^ self new initializeWith: aPath and: aRatio
]

{ #category : #'instance creation' }
LoadedBoard class >> pathValidation: aPath [

	aPath size < 1 ifTrue: [
		Error signal: 'Path should have a least one box' ]
]

{ #category : #'as yet unclassified' }
LoadedBoard >> findBoxIn: aPosition [

	^ path at: aPosition
]

{ #category : #initialization }
LoadedBoard >> initializeWith: aPath and: aRatio [

	path := aPath.
	parsecsToBoxesRatio := aRatio.

	path withIndexDo: [ :box :index | box position: index ]
]

{ #category : #accessing }
LoadedBoard >> length [
	
	^ path size.
]

{ #category : #'as yet unclassified' }
LoadedBoard >> normalizeAll: spaceships [

	self normalizeForwards: spaceships.
	self normalizeFirstBox: spaceships.
	self normalizeBackwards: spaceships
]

{ #category : #'as yet unclassified' }
LoadedBoard >> normalizeBackwards: spaceships [

	spaceships do: [ :aSpaceship |
		aSpaceship position < 1 ifTrue: [
			aSpaceship move: self length.
			aSpaceship subtractLap ] ]
]

{ #category : #'as yet unclassified' }
LoadedBoard >> normalizeFirstBox: spaceships [

	spaceships do: [ :aSpaceship |
		(aSpaceship lapsCompleted = 0 and: aSpaceship position < 1) ifTrue: [
			aSpaceship move: -1 * aSpaceship position + 1 ] ]
]

{ #category : #'as yet unclassified' }
LoadedBoard >> normalizeForwards: spaceships [

	spaceships do: [ :aSpaceship |
		[ aSpaceship position > self length ] whileTrue: [
			aSpaceship move: -1 * self length.
			aSpaceship addLap ] ]
]

{ #category : #private }
LoadedBoard >> normalizeOne: aSpaceship [

	[ aSpaceship position > self length ] whileTrue: [
        aSpaceship move: -1 * self length.
        aSpaceship addLap ].
]
