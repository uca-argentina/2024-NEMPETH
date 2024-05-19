Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'turn',
		'spaceships',
		'dices',
		'lapsToWin'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> amountOfLapsToWinValidation: amountOfLapsToWin [

	amountOfLapsToWin < 1 ifTrue: [
		Error signal: 'Laps to win should be greater than zero' ]
]

{ #category : #'instance creation' }
Game class >> createWith: aCollectionOfSpaceships and: aCollectionOfDices [

	self dicesValidation: aCollectionOfDices.
	self spaceshipsValidation: aCollectionOfSpaceships.

	^ self new
		  initializeWith: aCollectionOfSpaceships
		  and: aCollectionOfDices
]

{ #category : #'instance creation' }
Game class >> createWith: aCollectionOfSpaceships and: aCollectionOfDices andLapsToWin: amountOfLapsToWin [

	self dicesValidation: aCollectionOfDices.
	self spaceshipsValidation: aCollectionOfSpaceships.
	self amountOfLapsToWinValidation: amountOfLapsToWin.

	^ self new
		  initializeWith: aCollectionOfSpaceships
		  and: aCollectionOfDices
		  andLapsToWin: amountOfLapsToWin
]

{ #category : #'instance creation' }
Game class >> dicesValidation: aCollectionOfDices [

	aCollectionOfDices size < 1 ifTrue: [
		Error signal: 'Game should have a least one die' ]
]

{ #category : #'instance creation' }
Game class >> spaceshipsValidation: aCollectionOfSpaceships [

	aCollectionOfSpaceships size < 2 ifTrue: [
		Error signal: 'Game should have a least two spaceships' ]
]

{ #category : #'as yet unclassified' }
Game >> checkPositionsIn: aBoard [

	| positions |
	positions := OrderedCollection new.
	spaceships do: [ :aSpaceship |
		aSpaceship position > aBoard length
			ifTrue: [ positions add: aBoard length ]
			ifFalse: [ positions add: aSpaceship position ] ].

	^ positions
]

{ #category : #'as yet unclassified' }
Game >> checkWinnerOn: aBoard [

	^ spaceships
		  detect: [ :aSpaceship | aSpaceship lapsCompleted == lapsToWin ]
		  ifNone: [ nil ]
]

{ #category : #initialization }
Game >> initializeWith: aCollectionOfSpaceships and: aCollectionOfDices andLapsToWin: amountOfLapsToWin [

	turn := 1.
	spaceships := aCollectionOfSpaceships.
	dices := aCollectionOfDices.
	lapsToWin := amountOfLapsToWin
]

{ #category : #'as yet unclassified' }
Game >> playWith: aBoard [

	| aSpaceship boxToCheck positionsToMoveWithEffect |
	turn > spaceships size ifTrue: [ turn := 1 ].
	aSpaceship := spaceships at: turn.
	aSpaceship move: self throwDices.

	aBoard normalize: aSpaceship.
	
	(self checkWinnerOn: aBoard) ifNotNil: [
		aSpaceship move: aBoard length - aSpaceship position.
		^ self ].

	boxToCheck := aBoard findBoxIn: aSpaceship position.
	positionsToMoveWithEffect := boxToCheck applyEffect.
	aSpaceship move: positionsToMoveWithEffect.

	turn := turn + 1.
	self playWith: aBoard
]

{ #category : #'as yet unclassified' }
Game >> throwDices [

	| sum |
	sum := 0.
	dices do: [ :die | sum := sum + die throw ].
	^ sum
]

{ #category : #accessing }
Game >> verifyBattleAt: position [

	| spaceshipsFight diceRolls |
	
	position = 1 ifTrue: [ ^ self ].

	spaceshipsFight := spaceships select: [ :spaceship |
		                   spaceship position = position ].

	spaceshipsFight size = 2 ifFalse: [ ^ self ].

	diceRolls := spaceshipsFight collect: [ :spaceship | self throwDices ].

	diceRolls first > diceRolls second
		ifTrue: [
			spaceshipsFight first move: (-1 * position) + 1.
			spaceshipsFight first updateShield: -1 ]
		ifFalse: [
			spaceshipsFight second move: (-1 * position) + 1.
			spaceshipsFight second updateShield: -1 ]
]
