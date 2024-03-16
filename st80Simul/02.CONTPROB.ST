'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:12:10 pm'!

ProbabilityDistribution subclass: #ContinuousProbability
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Statistics'!


!ContinuousProbability methodsFor: 'probability functions'!

distribution: aCollection
	"This is a slow and dirty trapezoidal integration to determine the area under the probability function curve y=density (x) for x in the specified collection.  The method assumes that the collection contains numerically-ordered elements."

	| t aStream x1 x2 y1 y2 |
	t :=  0.0.
	aStream :=  ReadStream on: aCollection.
	x2 :=  aStream next.
	y2 :=  self density: x2.
	[x1 :=  x2.  x2 _ aStream next]
		whileTrue: 
			[y1 :=  y2.
		 	 y2 :=  self density: x2.
			 t :=  t + ((x2-x1)*(y2+y1))].
	^t*0.5! !
