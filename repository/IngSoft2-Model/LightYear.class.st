Class {
	#name : #LightYear,
	#superclass : #Unit,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
LightYear >> toParsec [
	^ (value / 3)
]
