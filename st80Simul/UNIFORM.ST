'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:13:15 pm'!

ContinuousProbability subclass: #Uniform
	instanceVariableNames: 'startNumber stopNumber '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Statistics'!


!Uniform methodsFor: 'accessing'!

mean
	^ (startNumber + stopNumber)/2!

variance
	^ (stopNumber - stopNumber) squared / 12! !

!Uniform methodsFor: 'probability functions'!

density: x 
	(x between: startNumber and: stopNumber)
		ifTrue: [^1.0 / (stopNumber - startNumber)]
		ifFalse: [^0]! !

!Uniform methodsFor: 'private'!

inverseDistribution: x
	"x is a random  number between 0 and 1"
	^startNumber + (x * (stopNumber - startNumber))!

setStart: begin toEnd: end
	startNumber :=  begin.
	stopNumber :=  end! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Uniform class
	instanceVariableNames: ''!


!Uniform class methodsFor: 'instance creation'!

from: begin to: end 
	begin > end
		ifTrue: [self error: 'illegal interval']
		ifFalse: [^self new setStart: begin toEnd: end]! !
