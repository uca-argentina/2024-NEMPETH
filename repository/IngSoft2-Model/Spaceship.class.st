Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'position',
		'shield',
		'lapsCompleted',
		'state',
		'id',
		'cards',
		'movementBySpeed',
		'avaliableForMercenary',
		'mercenaries'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Spaceship class >> createWithId: anId [
	^ self new initializeWith: anId.
]

{ #category : #comparing }
Spaceship >> > aSpaceship [

	^ self lapsCompleted > aSpaceship lapsCompleted
		  ifTrue: [ true ]
		  ifFalse: [
			  self lapsCompleted = aSpaceship lapsCompleted
				  ifTrue: [ self position > aSpaceship position ]
				  ifFalse: [ false ] ]
]

{ #category : #adding }
Spaceship >> addLap [
	lapsCompleted := lapsCompleted + 1
]

{ #category : #adding }
Spaceship >> addMercenary: aSpaceship [
	mercenaries add: aSpaceship.
	aSpaceship changeAvailabilityForMercenary.
]

{ #category : #adding }
Spaceship >> addSpeed [
	movementBySpeed := movementBySpeed + 1.
]

{ #category : #'as yet unclassified' }
Spaceship >> cards [
	^ cards
]

{ #category : #'as yet unclassified' }
Spaceship >> changeAvailabilityForMercenary [
	avaliableForMercenary := avaliableForMercenary not. 
]

{ #category : #'as yet unclassified' }
Spaceship >> changeTo: anState [ 
	state := anState.
]

{ #category : #accessing }
Spaceship >> id [
	^ id
]

{ #category : #initialization }
Spaceship >> initializeWith: anId [

	id := anId.
	avaliableForMercenary := true.
	mercenaries := OrderedCollection new.
	movementBySpeed := 0.
	position := 1.
	shield := 3.
	lapsCompleted := 0.
	cards := OrderedCollection new.
	state := AvailableState create
]

{ #category : #testing }
Spaceship >> isAvaliableForMercenary [
	^ avaliableForMercenary 
]

{ #category : #accessing }
Spaceship >> lapsCompleted [
	^ lapsCompleted
]

{ #category : #accessing }
Spaceship >> mercenaries [

	^ mercenaries
]

{ #category : #accessing }
Spaceship >> move: positionsToMove [

	position := position + positionsToMove
]

{ #category : #accessing }
Spaceship >> movementBySpeed [
	^ movementBySpeed
]

{ #category : #'as yet unclassified' }
Spaceship >> obtain: aCard [

	cards add: aCard
]

{ #category : #'as yet unclassified' }
Spaceship >> playTurn [

	^ state playTurn: self
]

{ #category : #accessing }
Spaceship >> position [

	^ position
]

{ #category : #'as yet unclassified' }
Spaceship >> recoverShields [

	shield := 3
]

{ #category : #removing }
Spaceship >> removeMercenary: aSpaceship [ 
	mercenaries remove: aSpaceship.
]

{ #category : #'as yet unclassified' }
Spaceship >> removeSpeed [
	movementBySpeed := movementBySpeed - 1.
]

{ #category : #removing }
Spaceship >> removeThis: aCard [
	self cards remove: aCard.
]

{ #category : #accessing }
Spaceship >> shield [
	^ shield
]

{ #category : #accessing }
Spaceship >> state [
	^ state
]

{ #category : #'as yet unclassified' }
Spaceship >> subtractLap [

	lapsCompleted := lapsCompleted - 1
]

{ #category : #'as yet unclassified' }
Spaceship >> updateShield: amount [
	shield := shield + amount.
]
