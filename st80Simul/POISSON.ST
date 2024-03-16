'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:12:54 pm'!

DiscreteProbability subclass: #Poisson
	instanceVariableNames: 'mu '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Statistics'!
Poisson comment:
'how many events occur in a unit time?
	used for sampling potential demands by customers for service

	The Poisson is typically the rate at which the service is provided.

	density function determines the probability that, in a unit interval, x events will occur.
'!


!Poisson methodsFor: 'accessing'!

mean
	^mu!

variance
	^mu! !

!Poisson methodsFor: 'random sampling'!

next
	| p n q |
	p :=  mu negated exp.
	n :=  0.
	q :=  1.0.
	[q :=  q * U next.
	 q >= p]
		whileTrue: [n :=  n + 1].
	^n! !

!Poisson methodsFor: 'probability functions'!

density: x

	x >= 0
		ifTrue: [^ ((mu raisedTo: x) * (mu negated exp)) / x factorial]
		ifFalse: [^0.0]! !

!Poisson methodsFor: 'private'!

setMean: p
	mu :=  p! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Poisson class
	instanceVariableNames: ''!


!Poisson class methodsFor: 'instance creation'!

mean: p

	p > 0.0
		ifTrue: [^self new setMean: p]
		ifFalse: [self error: 'mean must be greater than 0.0']! !
