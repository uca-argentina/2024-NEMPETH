Class {
	#name : #Wormhole,
	#superclass : #Box,
	#instVars : [
		'wormholeEnd'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Wormhole >> applyEffect: spaceships and: actualSpaceship [

	actualSpaceship move: wormholeEnd position - self position.
]

{ #category : #'as yet unclassified' }
Wormhole >> associateWith: aWormhole [

	wormholeEnd := aWormhole
]
