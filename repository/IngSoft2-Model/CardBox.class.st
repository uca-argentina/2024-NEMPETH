Class {
	#name : #CardBox,
	#superclass : #Box,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardBox class >> createWith: aDeck [ 
	^ self new initializeWith: aDeck
]

{ #category : #accessing }
CardBox >> applyEffect: spaceships and: actualSpaceship [

	| aCard |
	aCard := deck giveACard.

	actualSpaceship obtain: aCard
]

{ #category : #initialization }
CardBox >> initializeWith: aDeck [ 
	deck := aDeck
]
