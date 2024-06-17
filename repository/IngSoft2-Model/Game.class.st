Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'dices',
		'lapsToWin',
		'deck',
		'permanentCardsPlayed',
		'lastCardPlayed',
		'movementByAcceleration',
		'lastBox',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> amountOfLapsToWinValidation: amountOfLapsToWin [

	amountOfLapsToWin < 1 ifTrue: [
		Error signal: 'Laps to win should be greater than zero' ]
]

{ #category : #'as yet unclassified' }
Game class >> createWithNumberOfSpaceships: numberOfSpaceships and: aCollectionOfDices and: aDeck and: aBoard andLapsToWin: amountOfLapsToWin [ 

	self dicesValidation: aCollectionOfDices.
	self spaceshipsValidation: numberOfSpaceships.
	self amountOfLapsToWinValidation: amountOfLapsToWin.

	^ self new
		  initializeWith: numberOfSpaceships
		  and: aCollectionOfDices
		  and: aDeck
		  and: aBoard
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

{ #category : #adding }
Game >> addAcceleration [

	movementByAcceleration := movementByAcceleration + 1.
	lastCardPlayed := Acceleration.
	
]

{ #category : #'as yet unclassified' }
Game >> addPermanentCardPlayed: aCard [

	permanentCardsPlayed add: aCard
]

{ #category : #'as yet unclassified' }
Game >> applyMercenary: idOfMercenarySpaceship to: idOfActualSpaceship [ 
	
	| mercenarySpaceship actualSpaceship |
	
	mercenarySpaceship := spaceships detect: [ :aSpaceship | aSpaceship id = idOfMercenarySpaceship ].
	actualSpaceship := spaceships detect: [ :aSpaceship | aSpaceship id = idOfActualSpaceship ].
	
	mercenarySpaceship isAvaliableForMercenary ifTrue: [ actualSpaceship addMercenary: mercenarySpaceship. ].
	lastCardPlayed := Mercenary.
]

{ #category : #'as yet unclassified' }
Game >> applyRepeat: idOfTargetSpaceship [ 
	
	| affectedSpaceship index |
	affectedSpaceship := spaceships detect: [ :aSpaceship | aSpaceship id = idOfTargetSpaceship ].
	index := spaceships indexOf: affectedSpaceship.
	spaceships removeAt: index.
	
	lastBox applyEffect: spaceships and: affectedSpaceship.
	
	spaceships add: affectedSpaceship beforeIndex: index.
	board normalizeAll: spaceships.
	
	lastCardPlayed := Repeat.
]

{ #category : #'as yet unclassified' }
Game >> applySpeedWith: anIdOfSpaceship [

	| affectedSpaceship |
	affectedSpaceship := spaceships detect: [ :aSpaceship |
		                      aSpaceship id = anIdOfSpaceship ].
	
	affectedSpaceship addSpeed. 
	lastCardPlayed := Speed.
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
	| spaceshipsSortedById |
	spaceshipsSortedById := spaceships copy sort: [ :a :b | (a id) < (b id) ].
	^ spaceshipsSortedById collect: [ :spaceship | spaceship shield ]
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
Game >> initializeWith: numberOfSpaceships and: aCollectionOfDices and: aDeck and: aBoard andLapsToWin: amountOfLapsToWin [ 
	
	permanentCardsPlayed := OrderedCollection new.
	movementByAcceleration := 0.
	dices := aCollectionOfDices.
	deck := aDeck.
	board := aBoard.
	lapsToWin := amountOfLapsToWin.
	lastBox := NormalBox new.
	spaceships := self createSpaceships: numberOfSpaceships.
]

{ #category : #'as yet unclassified' }
Game >> passTurn [
	
	| actualSpaceship |
	
	actualSpaceship := spaceships removeFirst.
	actualSpaceship recoverShields.
	spaceships add: actualSpaceship.
	
]

{ #category : #'as yet unclassified' }
Game >> playCard: aCardArguments [ 

	| idOfSpaceship actualSpaceship idOfCard card |
	idOfSpaceship := aCardArguments at: 'idSpaceship'.
	actualSpaceship := spaceships detect: [ :aSpaceship | aSpaceship id = idOfSpaceship ].
	idOfCard := aCardArguments at: 'idCardToUse'.
	card := (actualSpaceship cards) detect: [ :aCard | aCard id = idOfCard ].
	actualSpaceship removeThis: card.
	
	card applyCardEffect: aCardArguments and: self.

]

{ #category : #'as yet unclassified' }
Game >> playTurn [

	| actualSpaceship boxToCheck winner |
	actualSpaceship := spaceships removeFirst.
	
	actualSpaceship playTurn ifFalse: [ ^ self ].
	actualSpaceship move: self throwDices + movementByAcceleration + actualSpaceship movementBySpeed.
	
	board normalizeOne: actualSpaceship.
	
	boxToCheck := board findBoxIn: actualSpaceship position.
	lastBox := boxToCheck.
	boxToCheck applyEffect: spaceships and: actualSpaceship.
	spaceships add: actualSpaceship.
	
	board normalizeAll: spaceships.
	
	winner := self checkWinnerOn: board.
	winner ifNotNil: [ ^ self ].
	
	self verifyBattleWith: actualSpaceship.

]

{ #category : #removing }
Game >> removeAcceleration [
	movementByAcceleration := movementByAcceleration - 1.

]

{ #category : #removing }
Game >> removeMercenary: idOfMercenarySpaceship and: idOfActualSpaceship [ 
	
	| mercenarySpaceship actualSpaceship |
	mercenarySpaceship := spaceships detect: [ :aSpaceship | aSpaceship id = idOfMercenarySpaceship ].
	actualSpaceship := spaceships detect: [ :aSpaceship | aSpaceship id = idOfActualSpaceship ].
	
	actualSpaceship removeMercenary: mercenarySpaceship.
	mercenarySpaceship changeAvailabilityForMercenary

]

{ #category : #removing }
Game >> removePermanentCardPlayed: aCard [ 
	permanentCardsPlayed remove: aCard.
	lastCardPlayed := Cancellation.
]

{ #category : #'as yet unclassified' }
Game >> removeSpeedWith: anIdOfSpaceship [ 
	| affectedSpaceship |
	affectedSpaceship := spaceships detect: [ :aSpaceship |
		                      aSpaceship id = anIdOfSpaceship ].
	
	affectedSpaceship removeSpeed. 
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

	| spaceshipsToFight sumOfThrowsActualSpaceship sumOfThrowsCounterSpaceship counterSpaceship |
	actualSpaceship position = 1 ifTrue: [ ^ self ].
	
	sumOfThrowsActualSpaceship := 0.
	sumOfThrowsCounterSpaceship := 0.
	
	spaceshipsToFight := spaceships select: [ :spaceship |
                           (spaceship position = actualSpaceship position) and: [ spaceship ~= actualSpaceship ]].

	spaceshipsToFight := spaceshipsToFight reject: [ :aSpaceship |
		                     aSpaceship mercenaries includes:
			                     actualSpaceship ].
		
	spaceshipsToFight size = 1 ifFalse: [ ^ self ].


	counterSpaceship := spaceshipsToFight first.

	1 to: (1 + actualSpaceship mercenaries size) do: [ :i | sumOfThrowsActualSpaceship := sumOfThrowsActualSpaceship + self throwDices  ].
	1 to: (1 + counterSpaceship mercenaries size) do: [ :i | sumOfThrowsCounterSpaceship := sumOfThrowsCounterSpaceship + self throwDices  ].

	 sumOfThrowsCounterSpaceship >= sumOfThrowsActualSpaceship
		ifTrue: [
			actualSpaceship move: -1 * actualSpaceship position + 1.
			actualSpaceship updateShield: -1.
			actualSpaceship mercenaries do: [ :aMercenary | aMercenary updateShield: -1 ]]
		ifFalse: [
			counterSpaceship move: -1 * counterSpaceship position + 1.
			counterSpaceship updateShield: -1.
			counterSpaceship mercenaries do: [ :aMercenary | aMercenary updateShield: -1 ]].
]
