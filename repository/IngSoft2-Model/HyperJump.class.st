Class {
	#name : #HyperJump,
	#superclass : #Box,
	#instVars : [
		'index',
		'parsecsToBoxesRatio',
		'collectionOfUnits'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJump class >> createWith: listLength andParsecsToBoxesRatio: aRatio [ 

	^ self new initializeWith: listLength and: aRatio.
]

{ #category : #accessing }
HyperJump >> applyEffect: spaceships and: actualSpaceship [

	actualSpaceship move:
		(collectionOfUnits  at: index) toParsec // parsecsToBoxesRatio.

	index = collectionOfUnits size ifTrue: [ index := 0 ].

	index := index + 1
]

{ #category : #initialization }
HyperJump >> initializeWith: boardLength and: aRatio [

	| maxPosibleLengthCollectionOfParsecs maxPosibleValueCollectionOfParsecs uniqueValuesSet setLength unitsMapping units setOfUnits |
	index := 1.
	parsecsToBoxesRatio := aRatio.

	maxPosibleLengthCollectionOfParsecs := (boardLength * 0.25) rounded.
	setLength := maxPosibleLengthCollectionOfParsecs atRandom.
	maxPosibleValueCollectionOfParsecs := (boardLength * 0.8) rounded.

	uniqueValuesSet := Set new.
	[ uniqueValuesSet size < setLength ] whileTrue: [
		uniqueValuesSet add: maxPosibleValueCollectionOfParsecs atRandom ].
	
	unitsMapping := {
        1 -> Parsec.
        2 -> LightYear.
    } asDictionary.
	units := #( 1 2 ).
	setOfUnits := uniqueValuesSet collect: [ :aValue |
		                    (unitsMapping at: (units atRandom)) createWith: aValue ].
	
	collectionOfUnits := setOfUnits asOrderedCollection.
	collectionOfUnits sort: [ :a :b | a toParsec > b toParsec ]
]

{ #category : #'as yet unclassified' }
HyperJump >> units [
	^ collectionOfUnits.
]
