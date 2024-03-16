'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:27:24 pm'!

DiscreteProbability subclass: #SampleSpace
	instanceVariableNames: 'data '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Statistics'!


!SampleSpace methodsFor: 'probability functions'!

density: x
	"x must be in the sample space;  the probability must sum over all occurrences of x in the sample space."

	(data includes: x)
		ifTrue: [^(data occurrencesOf: x) / data size]
		ifFalse: [^0]! !

!SampleSpace methodsFor: 'private'!

inverseDistribution: x
	
	^data at: (x*data size) truncated + 1!

setData: aCollection
	
	data :=  aCollection! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

SampleSpace class
	instanceVariableNames: ''!


!SampleSpace class methodsFor: 'instance creation'!

data: aCollection
	
	^self new setData: aCollection! !

!SampleSpace class methodsFor: 'Examples'!

heights

	| heights |
	heights :=  SampleSpace data: #(60 60 60 62 62 64 64 64 64 66 66 66 68 68 68 68 68 70 70 70).
	
	"what is the probability of randomly selecting a student with height 64?"
	heights density: 64.

	"what is the probability of randomly selecting a student whose height is between 60 and 64?"
	heights distribution: (60 to: 64 by: 2)! !
