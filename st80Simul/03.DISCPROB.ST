'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:12:18 pm'!

ProbabilityDistribution subclass: #DiscreteProbability
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Statistics'!


!DiscreteProbability methodsFor: 'probability functions'!

distribution: aCollection
	"Answer the sum of the discrete values of the density function for each element in the collection."

	| t |
	t :=  0.0.
	aCollection do: [:i | t :=  t + (self density: i)].
	^t! !
