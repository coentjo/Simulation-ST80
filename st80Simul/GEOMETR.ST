'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:12:38 pm'!

Bernoulli subclass: #Geometric
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Statistics'!
Geometric comment:
'How many repeated, independent Bernoulli trials are needed before the first success is obtained?

e.g., how many seconds before the next car arrives (as versus how many cars arrive in the next 20 sec as in a binomial question)'!


!Geometric methodsFor: 'accessing'!

mean
	^ 1.0 / prob!

variance
	^ (1.0 - prob) / prob squared! !

!Geometric methodsFor: 'probability functions'!

density: x

	x>0 ifTrue: [^prob * ((1.0 - prob) raisedTo: x-1)]
		ifFalse: [^0.0]! !

!Geometric methodsFor: 'private'!

inverseDistribution: x

	^(x ln / (1.0 - prob) ln) ceiling! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Geometric class
	instanceVariableNames: ''!


!Geometric class methodsFor: 'instance creation'!

mean: m

	^self parameter: m! !

!Geometric class methodsFor: 'Examples'!

CarsArriving

	| sample |
	
	"two cars arrive every minute"
	sample :=  Geometric mean: 60/2.

	"what is the probability that it will take 30 sec before the next car arrives?"
	sample density: 30.

	"Did the next car arrive in 30 to 40 seconds?"
	sample distribution: (30 to: 40)! !
