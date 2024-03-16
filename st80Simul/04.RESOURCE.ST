'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:13:54 pm'!

Object subclass: #Resource
	instanceVariableNames: 'pending resourceName '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Simulations'!


!Resource methodsFor: 'accessing'!

acquire
	^self!

addRequest: aDelayedEvent
	pending add: aDelayedEvent.
	self provideResources.
	aDelayedEvent pause.!

name
	^resourceName! !

!Resource methodsFor: 'private'!

provideResources
	^self!

setName: aString
	resourceName :=  aString.
	pending :=  SortedCollection new! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Resource class
	instanceVariableNames: ''!


!Resource class methodsFor: 'instance creation'!

named: resourceName
	^self new setName: resourceName! !
