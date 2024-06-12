Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
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
Game class >> createWithNumberOfSpaceships: numberOfSpaceships and: aCollectionOfDices andLapsToWin: amountOfLapsToWin [

	self dicesValidation: aCollectionOfDices.
	self spaceshipsValidation: numberOfSpaceships.
	self amountOfLapsToWinValidation: amountOfLapsToWin.

	^ self new
		  initializeWith: numberOfSpaceships
		  and: aCollectionOfDices
		  andLapsToWin: amountOfLapsToWin
]

{ #category : #'instance creation' }
Game class >> dicesValidation: aCollectionOfDices [

	aCollectionOfDices size < 1 ifTrue: [
		Error signal: 'Game should have a least one die' ]
]

{ #category : #'instance creation' }
Game class >> spaceshipsValidation: numberOfSpaceships [

	numberOfSpaceships < 2 ifTrue: [
		Error signal: 'Game should have a least two spaceships' ]
]

{ #category : #'as yet unclassified' }
Game >> checkPositionsOfSpaceships [

	^ spaceships collect: [ :spaceship | spaceship position ]
]

{ #category : #'as yet unclassified' }
Game >> checkRankingOn: aBoard [
	| sortedSpaceships |
	sortedSpaceships := spaceships sort: [ :a :b | a > b ].

	^ sortedSpaceships collect: [ :spaceship | spaceship id ]
]

{ #category : #'as yet unclassified' }
Game >> checkShieldsOfSpaceships [

	^ spaceships collect: [ :spaceship | spaceship shield ]
]

{ #category : #'as yet unclassified' }
Game >> checkWinnerOn: aBoard [

	^ spaceships
		  detect: [ :aSpaceship | aSpaceship lapsCompleted >= lapsToWin ]
		  ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
Game >> createSpaceships: numberOfSpaceships [

	| aCollectionOfSpaceships |
	aCollectionOfSpaceships := OrderedCollection new: numberOfSpaceships.
	1 to: numberOfSpaceships do: [ :i |
	aCollectionOfSpaceships add: (Spaceship createWithId: i) ].
	^ aCollectionOfSpaceships
]

{ #category : #initialization }
Game >> initializeWith: numberOfSpaceships and: aCollectionOfDices andLapsToWin: amountOfLapsToWin [

	spaceships := self createSpaceships: numberOfSpaceships.
	dices := aCollectionOfDices.
	lapsToWin := amountOfLapsToWin.
]

{ #category : #'as yet unclassified' }
Game >> passTurnOn: aBoard [
	
	| actualSpaceship |
	
	actualSpaceship := spaceships removeFirst.
	actualSpaceship recoverShields.
	spaceships add: actualSpaceship.
	
]

{ #category : #'as yet unclassified' }
Game >> playWith: aBoard [

	| actualSpaceship boxToCheck winner |
	actualSpaceship := spaceships removeFirst.

	actualSpaceship playTurn ifFalse: [ ^ self ].

	actualSpaceship move: self throwDices.
	aBoard normalizeOne: actualSpaceship.
	
	boxToCheck := aBoard findBoxIn: actualSpaceship position.
	boxToCheck applyEffect: spaceships and: actualSpaceship.
	spaceships add: actualSpaceship.
	
	aBoard normalizeAll: spaceships.
	
	winner := self checkWinnerOn: aBoard.
	winner ifNotNil: [ ^ self ].
	
	self verifyBattleWith: actualSpaceship.

]

{ #category : #'as yet unclassified' }
Game >> throwDices [

	| sum |
	sum := 0.
	dices do: [ :die | sum := sum + die throw ].
	^ sum
]

{ #category : #accessing }
Game >> verifyBattleWith: actualSpaceship [

	| spaceshipsFight diceRolls |
	
	actualSpaceship position = 1 ifTrue: [ ^ self ].

	spaceshipsFight := spaceships select: [ :spaceship |
		                   (spaceship position = actualSpaceship position) and: [ spaceship ~= actualSpaceship ]].
	
	spaceshipsFight add: actualSpaceship. 

	spaceshipsFight size = 2 ifFalse: [ ^ self ].

	diceRolls := spaceshipsFight collect: [ :spaceship | self throwDices ].

	diceRolls first >= diceRolls second
		ifTrue: [
			spaceshipsFight second move: (-1 * actualSpaceship position) + 1.
			spaceshipsFight second updateShield: -1 ]
		ifFalse: [
			spaceshipsFight first move: (-1 * actualSpaceship position) + 1.
			spaceshipsFight first updateShield: -1 ]


]
