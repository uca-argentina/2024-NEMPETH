Class {
	#name : #PathGenerator,
	#superclass : #Object,
	#instVars : [
		'path'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
PathGenerator class >> createWith: aLength and: aRatio [

	^ self new initializeWith: aLength and: aRatio.
]

{ #category : #initialization }
PathGenerator >> createWormhole [
	
	| wormholeOne wormholeTwo |
	
	wormholeOne := Wormhole new.
	wormholeTwo := Wormhole new.

	wormholeOne associateWith: wormholeTwo.
	wormholeTwo associateWith: wormholeOne.

	^OrderedCollection with: wormholeOne with: wormholeTwo.
]

{ #category : #initialization }
PathGenerator >> initializeWith: aLength and: aRatio [

	| randomGenerator randomValue |
	path := OrderedCollection new.
	randomGenerator := Random new.

	1 to: aLength - 3 do: [ :i |
		randomValue := randomGenerator next.

		randomValue <= 0.4 ifTrue: [ path add: NormalBox new ].
		(randomValue > 0.4 and: [ randomValue <= 0.6 ]) ifTrue: [
			path add: BlackHole new ].
		(randomValue > 0.6 and: [ randomValue <= 0.8 ]) ifTrue: [
			path add: HyperSpaceJump new ].
		(randomValue > 0.8 and: [ randomValue <= 0.9 ]) ifTrue: [
			path add: (MoonWalk createWith: aLength atRandom) ].
		(randomValue > 0.9 and: [ randomValue <= 0.98 ]) ifTrue: [
			path add:
				(HyperJump createWith: aLength andParsecsToBoxesRatio: aRatio) ].
		randomValue > 0.98 ifTrue: [ path add: AtomicBomb new ] ].

	path addAll: self createWormhole.
	path := path shuffled.
	path addFirst: NormalBox new
]

{ #category : #initialization }
PathGenerator >> path [
	^path.
]
