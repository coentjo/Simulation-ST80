'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:13:02 pm'!

Stream subclass: #ProbabilityDistribution
	instanceVariableNames: ''
	classVariableNames: 'U '
	poolDictionaries: ''
	category: 'Statistics'!
ProbabilityDistribution comment:
'Initialization of the class is needed.  Use

	ProbabilityDistribution initialize'!


!ProbabilityDistribution methodsFor: 'random sampling'!

atEnd
	^false!

next
	"This is a general random number generation method for any probability law;  use the (0,1) uniformly distributed random varible U as the value of the law's distribution function.  Obtain the next random value and then solve for the inverse.  The inverse solution is defined by the subclass."

	^self inverseDistribution: U next! !

!ProbabilityDistribution methodsFor: 'probability functions'!

density: x

	self subclassResponsibility!

distribution: aCollection

	self subclassResponsibility! !

!ProbabilityDistribution methodsFor: 'private'!

computeSample: m outOf: n

	m>n ifTrue: [^0.0].
	^n factorial / (n-m) factorial!

inverseDistribution: x
	self subclassResponsibility! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

ProbabilityDistribution class
	instanceVariableNames: ''!


!ProbabilityDistribution class methodsFor: 'instance creation'!

new
	
	^self basicNew! !

!ProbabilityDistribution class methodsFor: 'class initialization'!

initialize
	"Uniformly distributed random numbers in the range [o,1]."

	U :=  Random new! !

ProbabilityDistribution initialize!
