'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:27:42 pm'!

Object subclass: #DelayedEvent
	instanceVariableNames: 'resumptionSemaphore resumptionCondition '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Simulations'!


!DelayedEvent methodsFor: 'accessing'!

condition
	"Answer a condition under which the event should be sequenced."

	^resumptionCondition!

condition: anObject
	"The argument, anObject, is the condition under which the event should be sequenced."

	resumptionCondition :=  anObject! !

!DelayedEvent methodsFor: 'comparing'!

<= aDelayedEvent
	"Answer whether the receiver should be sequenced before the argument."
	
	resumptionCondition isNil
		ifTrue: [^true]
		ifFalse: [^resumptionCondition <= aDelayedEvent condition]! !

!DelayedEvent methodsFor: 'scheduling'!

pause
	"Suspend the current active process, that is, the current event that is running."

	Simulation active stopProcess.
	resumptionSemaphore wait!

resume
	"Resume the suspended process."
	Simulation active startProcess.
	resumptionSemaphore signal.
	^resumptionCondition! !

!DelayedEvent methodsFor: 'private'!

initialize
	resumptionSemaphore :=  Semaphore new!

setCondition: anObject
	self initialize.
	resumptionCondition :=  anObject! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

DelayedEvent class
	instanceVariableNames: ''!


!DelayedEvent class methodsFor: 'instance creation'!

new
	^super new initialize!

onCondition: anObject
	^super new setCondition: anObject! !
