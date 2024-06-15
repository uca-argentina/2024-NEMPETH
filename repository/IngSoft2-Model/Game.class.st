Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'dices',
		'lapsToWin',
		'deck',
		'permanentCardsPlayed',
		'lastCardPlayed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> amountOfLapsToWinValidation: amountOfLapsToWin [

	amountOfLapsToWin < 1 ifTrue: [
		Error signal: 'Laps to win should be greater than zero' ]
]

{ #category : #'as yet unclassified' }
Game class >> createWithNumberOfSpaceships: numberOfSpaceships and: aCollectionOfDices and: aDeck andLapsToWin: amountOfLapsToWin [

	self dicesValidation: aCollectionOfDices.
	self spaceshipsValidation: numberOfSpaceships.
	self amountOfLapsToWinValidation: amountOfLapsToWin.

	^ self new
		  initializeWith: numberOfSpaceships
		  and: aCollectionOfDices
		  and: aDeck
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
Game >> checkAmountOfCardsOfSpaceships [
	| spaceshipsSortedById |
	spaceshipsSortedById := spaceships copy sort: [ :a :b | (a id) < (b id) ].
	^ spaceshipsSortedById collect: [ :spaceship | (spaceship cards) size ]
]

{ #category : #'as yet unclassified' }
Game >> checkPositionsOfSpaceships [
	| spaceshipsSortedById |
	spaceshipsSortedById := spaceships copy sort: [ :a :b | (a id) < (b id) ].
	^ spaceshipsSortedById collect: [ :spaceship | spaceship position ]
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

	| aCollectionOfSpaceships anSpaceship |
	aCollectionOfSpaceships := OrderedCollection new: numberOfSpaceships.
	1 to: numberOfSpaceships do: [ :i |
		anSpaceship := (Spaceship createWithId: i).
		anSpaceship obtain: (deck giveACard). 
		anSpaceship obtain: (deck giveACard).
	aCollectionOfSpaceships add: anSpaceship ].
	^ aCollectionOfSpaceships
]

{ #category : #'as yet unclassified' }
Game >> getLastCardPlayed [
	^ lastCardPlayed
]

{ #category : #'as yet unclassified' }
Game >> getPermanentCardPlayed [
	^ permanentCardsPlayed
]

{ #category : #initialization }
Game >> initializeWith: numberOfSpaceships and: aCollectionOfDices and: aDeck andLapsToWin: amountOfLapsToWin [ 
	
	permanentCardsPlayed := OrderedCollection new.
	dices := aCollectionOfDices.
	deck := aDeck.
	lapsToWin := amountOfLapsToWin.
	spaceships := self createSpaceships: numberOfSpaceships.
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
