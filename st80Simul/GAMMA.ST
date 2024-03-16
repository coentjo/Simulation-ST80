'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:12:32 pm'!

Exponential subclass: #Gamma
	instanceVariableNames: 'N '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Statistics'!


!Gamma methodsFor: 'accessing'!

mean
	^super mean*N!

variance
	^super variance*N! !

!Gamma methodsFor: 'probability functions'!

density: x
	| t |
	x > 0.0
		ifTrue: [t :=  mu * x.
			^(mu raisedTo: N) / (self gamma: N) *(x raisedTo: N-1) * t negated exp]
		ifFalse: [^0.0]! !

!Gamma methodsFor: 'private'!

gamma: n
	| t |
	t :=  n - 1.0.
	^self computeSample: t outOf: t!

setEvents: events
	N :=  events! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Gamma class
	instanceVariableNames: ''!


!Gamma class methodsFor: 'instance creation'!

events: k mean: p

	|  events |
	events :=  k truncated.
	events > 0
		ifTrue: [^(self parameter: events/p) setEvents: events]
		ifFalse: [self error: 'the number of events must be greater than 0']! !
