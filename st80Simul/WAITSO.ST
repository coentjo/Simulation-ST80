'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:14:25 pm'!

DelayedEvent subclass: #WaitingSimulationObject
	instanceVariableNames: 'amount resource '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Simulations'!


!WaitingSimulationObject methodsFor: 'task language'!

consume: aNumber
	amount :=  (amount - aNumber) max: 0!

release
	resource produce: amount.
	amount :=  0!

release: anAmount
	resource produce: anAmount.
	amount :=  amount - anAmount! !

!WaitingSimulationObject methodsFor: 'accessing'!

amount
	^amount!

name
	^resource name!

resource
	^resource!

resource: aResource
	resource :=  aResource! !

!WaitingSimulationObject methodsFor: 'private'!

setAmount: aNumber resource: aResource
	amount :=  aNumber.
	resource :=  aResource! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

WaitingSimulationObject class
	instanceVariableNames: ''!


!WaitingSimulationObject class methodsFor: 'instance creation'!

for: amount of: aResource withPriority: aNumber
	^(self onCondition: aNumber) setAmount: amount resource: aResource!

for: amount withPriority: aNumber
	^(self onCondition: aNumber) setAmount: amount resource: nil! !
