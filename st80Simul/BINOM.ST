'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:12:05 pm'!

Bernoulli subclass: #Binomial
	instanceVariableNames: 'N '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Statistics'!
Binomial comment:
'how many successes occurred in N trials?

density funciton answers what is the probability that x successes will occur in the next N trials?

i.e., N repeated Bernoulli trials'!


!Binomial methodsFor: 'random sampling'!

next
	
	|t|
	t :=  0.
	N timesRepeat: [t :=  t + super next].
	^t! !

!Binomial methodsFor: 'probability functions'!

density: x

	(x between: 0 and: N)
		ifTrue: [^((self computeSample: x outOf: N) / (self computeSample: x outOf: x)) * (prob raisedTo: x)*((1.0 - prob) raisedTo: N-x)]
		ifFalse: [^0.0]! !

!Binomial methodsFor: 'private'!

events: n mean: m

	N :=  n truncated.
	self setParameter: m/N! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Binomial class
	instanceVariableNames: ''!


!Binomial class methodsFor: 'instance creation'!

events: n mean: m

	n truncated <= 0 ifTrue: [self error: 'number of events must be > 0'].
	^self new events: n mean: m! !

!Binomial class methodsFor: 'Examples'!

FlippingCoins

	| sampleA sampleB |
	sampleA :=  Bernoulli parameter: 0.5.

	"Did I get heads?"
	sampleA next.

	sampleB :=  Binomial events: 5 mean: 2.5.
	
	"How many heads did I get in 5 trials?"
	sampleB next! !
