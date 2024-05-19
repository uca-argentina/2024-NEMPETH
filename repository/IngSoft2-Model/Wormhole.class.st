Class {
	#name : #Wormhole,
	#superclass : #Box,
	#instVars : [
		'wormholeEnd'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Wormhole >> applyEffect [

	^ wormholeEnd position - self position
]

{ #category : #'as yet unclassified' }
Wormhole >> associateWith: aWormhole [

	wormholeEnd := aWormhole
]

{ #category : #'as yet unclassified' }
Wormhole >> isWormhole [
	^ true
]
