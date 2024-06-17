Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'idForCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Deck class >> create [
	^ self new initializeWith
]

{ #category : #'as yet unclassified' }
Deck >> giveACard [
    | aCard randomValue cardMapping |
    cardMapping := {
        1 -> Speed.
        2 -> Mercenary.
        3 -> Acceleration.
        4 -> Cancellation.
        5 -> Redo.
        6 -> Repeat.
    } asDictionary.
    randomValue := #(1 2 3 4 5 6) atRandom.
    aCard := (cardMapping at: randomValue) createWithId: idForCard.
	 idForCard := idForCard + 1.
    
    ^ aCard

]

{ #category : #initialization }
Deck >> initializeWith [
	idForCard := 1
]
