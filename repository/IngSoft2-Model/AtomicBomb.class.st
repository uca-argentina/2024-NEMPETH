Class {
	#name : #AtomicBomb,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
AtomicBomb >> applyEffect: spaceships and: turn [

	spaceships do: [ :aSpaceship |
		aSpaceship move: -1 * aSpaceship position + 1.
		aSpaceship updateShield: -1 ]
]
