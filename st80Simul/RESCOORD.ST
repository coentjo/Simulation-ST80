'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:14:01 pm'!

Resource subclass: #ResourceCoordinator
	instanceVariableNames: 'whoIsWaiting '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Simulations'!


!ResourceCoordinator methodsFor: 'accessing'!

customersWaiting
	^whoIsWaiting == #customer!

queueLength
	^pending size!

serversWaiting
	^whoIsWaiting == #server! !

!ResourceCoordinator methodsFor: 'task language'!

acquire
	|waiting|
	self customersWaiting ifTrue: [^self giveService].
	"get here if there is no customer waiting for the server."
	waiting :=  WaitingSimulationObject for: 1 withPriority: 0.
	whoIsWaiting :=  #server.
	self addRequest: waiting.
	^waiting resource!

producedBy: aCustomer
	|waiting|
	waiting :=  WaitingSimulationObject for: 1
					of: aCustomer
					withPriority: 0.
	self serversWaiting ifTrue: [^self getServiceFor: waiting].
	whoIsWaiting :=  #customer.
	self addRequest: waiting! !

!ResourceCoordinator methodsFor: 'private'!

getServiceFor: aCustomerRequest

	| aServerRequest |
	aServerRequest :=  pending removeFirst.
	pending isEmpty ifTrue: [whoIsWaiting :=  #none].
	aServerRequest resource: aCustomerRequest.
	aServerRequest resume.
	aCustomerRequest pause!

giveService
	|aCustomerRequest|
	aCustomerRequest:=  pending removeFirst.
	pending isEmpty ifTrue: [whoIsWaiting :=  #none].
	^aCustomerRequest!

setName: aString
	super setName: aString.
	whoIsWaiting :=  #none! !
