'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:14:48 pm'!

Object subclass: #SimulationObjectRecord
	instanceVariableNames: 'entranceTime duration '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Simulation statistics gathering'!


!SimulationObjectRecord methodsFor: 'accessing'!

duration
	^duration!

entrance
	^entranceTime!

entrance: currentTime
	entranceTime :=  currentTime!

exit
	^entranceTime + duration!

exit: currentTime
	duration :=  currentTime - entranceTime! !

!SimulationObjectRecord methodsFor: 'printing'!

printOn: aStream
	entranceTime printOn: aStream.
	aStream tab.
	duration printOn: aStream! !
