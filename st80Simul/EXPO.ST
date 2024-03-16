'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:12:25 pm'!

ContinuousProbability subclass: #Exponential
	instanceVariableNames: 'mu '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Statistics'!


!Exponential methodsFor: 'accessing'!

mean
	^1.0/mu!

variance
	^1.0/(mu*mu)! !

!Exponential methodsFor: 'probability functions'!

density: x
	x > 0.0
		ifTrue: [^mu * (mu*x) negated exp]
		ifFalse: [^0.0]!

distribution: anInterval
	anInterval last <= 0.0
		ifTrue: [^0.0]
		ifFalse: [^1.0 - (mu * anInterval last) negated exp - (anInterval first > 0.0 ifTrue: [self distribution: (0.0 to: anInterval first)] ifFalse: [0.0])]! !

!Exponential methodsFor: 'private'!

inverseDistribution: x
	^ x ln negated / mu!

setParameter: p
	mu :=  p! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Exponential class
	instanceVariableNames: ''!


!Exponential class methodsFor: 'instance creation'!

mean: p
	^self parameter: 1.0/p!

parameter:  p
	
	p > 0.0
		ifTrue: [^self new setParameter: p]
		ifFalse: [self error: 'The probability parameter must be greater than 0.0']! !
