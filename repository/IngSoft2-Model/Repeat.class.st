Class {
	#name : #Repeat,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Repeat >> applyCardEffect: aCardArguments and: aGame [ 
	
	| idOfTargetSpaceship |

	idOfTargetSpaceship := aCardArguments at: 'idTargetSpaceship'.
	
	aGame applyRepeat: idOfTargetSpaceship.	
]
