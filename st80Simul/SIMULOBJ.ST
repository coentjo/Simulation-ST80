'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:14:20 pm'!

Object subclass: #SimulationObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Simulations'!
SimulationObject comment:
'A SimulationObject represents any object that can be given a sequence of tasks to do.  The class specifies a general control sequence by which the object enters, carries out its tasks, and leaves the simulation.

	Resources can be produced, consumed, acquired, and tested by queries such as amountAvailable, serversWaiting, custoemrsWaiting?'!


!SimulationObject methodsFor: 'initialization'!

initialize
	"Do nothing.  Subclasses will initialize instance variables."

	^self! !

!SimulationObject methodsFor: 'simulation control'!

finishUp
	"Tell the simulation that the receiver is done with its tasks."
	Simulation active exit: self!

startUp
	Simulation active enter: self.
	"First tell the simulation that the receiver is beginning to do my tasks."
	self tasks.
	self finishUp!

tasks
	"Do nothing.  Subclasses will schedule activities."
	^self! !

!SimulationObject methodsFor: 'task language'!

acquire: amount ofResource: resourceName 
	"Get the resource and then tell it to acquire amount of it.  Answers 
	an instance of StaticResource."

	^(Simulation active provideResourceFor: resourceName)
		acquire: amount withPriority: 0!

acquire: amount ofResource: resourceName withPriority: priority 
	"Returns a StaticResource"
	^(Simulation active provideResourceFor: resourceName)
		acquire: amount withPriority: priority!

acquireResource: resourceName
	"Returns a StaticResource"
	^(Simulation active provideResourceFor: resourceName) acquire!

holdFor: aTimeDelay
	Simulation active delayFor: aTimeDelay!

inquireFor: amount ofResource: resourceName
	^(Simulation active provideResourceFor: resourceName) amountAvailable >= amount!

numberOfProvidersOfResource: resourceName
	| resource |
	resource :=  Simulation active provideResourceFor: resourceName.
	resource serversWaiting
		ifTrue: [^resource queueLength]
		ifFalse: [^0]!

numberOfRequestersOfResource: resourceName
	| resource |
	resource :=  Simulation active provideResourceFor: resourceName.
	resource customersWaiting
		ifTrue: [^resource queueLength]
		ifFalse: [^0]!

produce: amount ofResource: resourceName
	Simulation active produce: amount of: resourceName!

produceResource: resourceName
	^(Simulation active provideResourceFor: resourceName) producedBy: self!

release: aStaticResource
	^aStaticResource release!

resourceAvailable: resourceName
	"Does the active simulaton have a resource with this attribute available?"
	^Simulation active includesResourceFor: resourceName!

resume: anEvent
	^anEvent resume!

stopSimulation
	Simulation active finishUp! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

SimulationObject class
	instanceVariableNames: ''!


!SimulationObject class methodsFor: 'instance creation'!

new
	^super new initialize! !
