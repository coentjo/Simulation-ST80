'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:14:11 pm'!

Object subclass: #Simulation
	instanceVariableNames: 'resources currentTime eventQueue processCount '
	classVariableNames: 'RunningSimulation '
	poolDictionaries: ''
	category: 'Simulations'!
Simulation comment:
'

Expects to handle several kinds of resources, represented abstractly by class Resource, and concretely by subclasses of Resource:  ResourceProvider, StaticResource, and ResourceCoordinator'!


!Simulation methodsFor: 'initialization'!

activate
	"This instance is now the active simulation"	
	RunningSimulation :=  self!

defineArrivalSchedule
	"A subclass specifies the schedule by which simulation objects dynamically enter into the simulation."
	^self!

defineResources
	"A subclass specifies the schedule by which simulation objects that are initially entered into the simulation."
	^self!

initialize
	resources :=  Set new.
	currentTime :=  0.0.
	processCount :=  0.
	eventQueue :=  SortedCollection new! !

!Simulation methodsFor: 'task language'!

coordinate: resourceName
	(self includesResourceFor: resourceName)
		ifFalse: [resources add: ( ResourceCoordinator named: resourceName)]!

produce: amount of: resourceName 
	(self includesResourceFor: resourceName)
		ifTrue: [(self provideResourceFor: resourceName)
				produce: amount
			"sends produce: to a ResourceProvider"]
		ifFalse: [resources add: (ResourceProvider named: resourceName with: amount)]!

schedule: actionBlock after: timeDelay
	self schedule: actionBlock at: currentTime + timeDelay!

schedule: aBlock at: timeInteger
	"This is the mechanism for scheduling a single action."
	self newProcessFor: [self delayUntil: timeInteger.  aBlock value]!

scheduleArrivalOf: aSimulationObjectClass accordingTo: aProbabilityDistribution 
	"This means start now"

	self
		scheduleArrivalOf: aSimulationObjectClass
		accordingTo: aProbabilityDistribution
		startingAt: currentTime!

scheduleArrivalOf: aSimulationObjectClass accordingTo: aProbabilityDistribution startingAt: timeInteger 
	"Note that aSimulationObjectClass is the class Simulation or one of 
	its subclasses.  The real work is done in the private message 
	schedule:startingAt:andThenEvery:. "

	self
		schedule: [aSimulationObjectClass new startUp]
		startingAt: timeInteger
		andThenEvery: aProbabilityDistribution!

scheduleArrivalOf: aSimulationObject at: timeInteger 
	self schedule: [aSimulationObject startUp]
		at: timeInteger! !

!Simulation methodsFor: 'scheduling'!

delayFor: timeDelay
	self delayUntil: currentTime+timeDelay!

delayUntil: aTime
	| delayEvent |
	delayEvent :=  DelayedEvent onCondition: aTime.
	eventQueue add: delayEvent.
	"self stopProcess."
	delayEvent pause.
	"self startProcess"!

newProcessFor: aBlock
	self startProcess.
	[aBlock value. self stopProcess] fork!

startProcess
	processCount :=  processCount +1!

stopProcess
	processCount :=  processCount - 1! !

!Simulation methodsFor: 'simulation control'!

enter: anObject
	^self!

exit: anObject
	^self!

finishUp
	"We need to empty out the event queue."
	eventQueue :=  SortedCollection new.
	^nil!

proceed
	| eventProcess |
	[self readyToContinue]
		whileFalse: [Processor yield].
	eventQueue isEmpty
		ifTrue: [^self finishUp]
		ifFalse: 
			[eventProcess :=  eventQueue removeFirst.
			currentTime :=  eventProcess condition.
			eventProcess resume]!

startUp
	self activate.
	self defineResources.
	self defineArrivalSchedule! !

!Simulation methodsFor: 'accessing'!

includesResourceFor: resourceName 
	| test |
	test :=  resources 
				detect: [:each | each name = resourceName]
				ifNone: [nil].
	^test notNil!

provideResourceFor: resourceName
	^resources detect: [ :each | each name = resourceName]!

time
	^currentTime! !

!Simulation methodsFor: 'private'!

readyToContinue
	^processCount = 0!

schedule: aBlock startingAt: timeInteger andThenEvery: aProbabilityDistribution 
	self newProcessFor: 
			[self delayUntil: timeInteger.
			self newProcessFor: aBlock copy.
			aProbabilityDistribution do: 
				[:nextTimeDelay | 
				self delayFor: nextTimeDelay.
				self newProcessFor: aBlock copy]]! !

!Simulation methodsFor: 'reporting'!

report: label
	Transcript show: label.
	Transcript tab.
	Transcript show: 'pc: ', processCount printString.
	Transcript space.
	Transcript show: 'procs: ', (Processor processesAt: Processor userSchedulingPriority) printString.
	Transcript space.
	Transcript show: 'events: ', eventQueue size printString.
	Transcript cr! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Simulation class
	instanceVariableNames: ''!


!Simulation class methodsFor: 'instance creation'!

new
	^super new initialize! !

!Simulation class methodsFor: 'accessing'!

active
	^RunningSimulation! !
