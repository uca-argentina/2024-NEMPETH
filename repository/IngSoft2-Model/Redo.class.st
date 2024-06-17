Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Redo >> applyCardEffect: aCardArguments and: aGame [ 
	
	| card |

	card := (aGame getLastCardPlayed) createWithId: self id.
	card applyCardEffect: aCardArguments and: aGame.
]
