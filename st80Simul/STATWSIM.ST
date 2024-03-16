'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:26:02 pm'!

Simulation subclass: #StatisticsWithSimulation
	instanceVariableNames: 'statistics '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Simulation statistics gathering'!


!StatisticsWithSimulation methodsFor: 'initialization'!

initialize
	super initialize.
	statistics :=  Dictionary new.! !

!StatisticsWithSimulation methodsFor: 'simulation scheduling'!

enter: anObject 
	statistics at: anObject put: (SimulationObjectRecord new entrance: currentTime)!

exit: anObject 
	(statistics at: anObject) exit: currentTime! !

!StatisticsWithSimulation methodsFor: 'statistics'!

printStatisticsOn: aStream 
	| stat |
	aStream cr.
	aStream nextPutAll: ' Object'.
	aStream tab.
	aStream nextPutAll: 'Entrance Time'.
	aStream tab.
	aStream nextPutAll: 'Duration'.
	aStream cr.
	stat :=  SortedCollection sortBlock: [:i :j | i value entrance <= j value entrance].
	statistics associationsDo: [:each | stat add: each]. 
	stat do: 
		[:anAssociation | 
		aStream cr.
		anAssociation key printOn: aStream.
		aStream tab.
		anAssociation value printOn: aStream]! !
