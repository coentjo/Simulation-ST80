'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:11:52 pm'!

DiscreteProbability subclass: #Bernoulli
	instanceVariableNames: 'prob '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Statistics'!
Bernoulli comment:
'Does an event occur?

density function answers the probability of occurrence of one of two events'!


!Bernoulli methodsFor: 'accessing'!

mean
	^prob!

variance
	^prob * (1.0 - prob)! !

!Bernoulli methodsFor: 'probability functions'!

density: x

	x=1 ifTrue: [^prob].
	x=0 ifTrue: [^1.0-prob].
	self error: ' outcomes of a Bernoulli can only be 1 or 0'! !

!Bernoulli methodsFor: 'private'!

inverseDistribution: x

	x <= prob
		ifTrue: [^1]
		ifFalse: [^0]!

setParameter: aNumber
	prob := aNumber! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Bernoulli class
	instanceVariableNames: ''!


!Bernoulli class methodsFor: 'instance creation'!

parameter: aNumber
	(aNumber between: 0.0 and: 1.0)
		ifTrue: [^self new setParameter: aNumber]
		ifFalse: [^self error: 'The probability must be between 0.0 and 1.0']! !

!Bernoulli class methodsFor: 'Examples'!

Cardgame

	"is the first draw of a card an ace?"
	(Bernoulli parameter: 4/52) next

	"does a car arrive in the next second?"

	"will a machine break down today?"! !
