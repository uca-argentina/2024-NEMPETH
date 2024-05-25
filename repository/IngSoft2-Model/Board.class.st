Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'path'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> createWith: aLength [

	self lengthValidation: aLength.
	^ self new initializeWith: aLength
]

{ #category : #'instance creation' }
Board class >> lengthValidation: aLength [

	(aLength < 0 or: aLength \\ 50 ~= 0) ifTrue: [
		Error signal:
			'Board length should be multiple of 50 and greater than 0' ]
]

{ #category : #'as yet unclassified' }
Board >> createWormhole [
	
	| wormholeOne wormholeTwo |
	
	wormholeOne := Wormhole new.
	wormholeTwo := Wormhole new.

	wormholeOne associateWith: wormholeTwo.
	wormholeTwo associateWith: wormholeOne.

	^OrderedCollection with: wormholeOne with: wormholeTwo.
]

{ #category : #'as yet unclassified' }
Board >> findBoxIn:  aPosition [

	^ path at: aPosition
]

{ #category : #initialization }
Board >> initializeWith: aLength [

	path := OrderedCollection new.

	1 to: 0.2 * aLength do: [ :i | path add: HyperSpaceJump new ].
	1 to: 0.2 * aLength do: [ :i | path add: BlackHole new ].
	1 to: 0.1 * aLength do: [ :i | path add: (MoonWalk createWith: self length) ].
	1 to: 0.08 * aLength do: [ :i | path add: (HyperJump createWith: self length) ].
	1 to: 0.02 * aLength do: [ :i | path add: AtomicBomb new ].
	1 to: ((0.2 * aLength) - 1) do: [ :i | path add: NormalBox new ].
	1 to: (0.1 * aLength) do: [ :i | path addAll: self createWormhole ].
	
	path := path shuffled.
	path addFirst: NormalBox new. 
	
	path withIndexDo: [ :box :index | box position: index ]


	
]

{ #category : #accessing }
Board >> length [
	^ path size.
]

{ #category : #accessing }
Board >> path [
	^ path
]
