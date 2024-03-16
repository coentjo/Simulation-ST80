'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:14:06 pm'!

Resource subclass: #ResourceProvider
	instanceVariableNames: 'amountAvailable '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Simulations'!


!ResourceProvider methodsFor: 'accessing'!

amountAvailable
	^amountAvailable! !

!ResourceProvider methodsFor: 'task language'!

acquire: amountNeeded withPriority: priorityNumber 
	| waiting |
	waiting :=  WaitingSimulationObject
					for: amountNeeded 
					of: self
					withPriority: priorityNumber.
	self addRequest: waiting.
	^waiting!

produce: amount
	amountAvailable :=  amountAvailable + amount.
	self provideResources! !

!ResourceProvider methodsFor: 'private'!

provideResources
	| waiting |
	[pending isEmpty not and: [pending first amount <= amountAvailable]]
		whileTrue: 
			[waiting :=  pending removeFirst.
			amountAvailable :=  amountAvailable - waiting amount.
			waiting resume]!

setName: aResourceName with: amount
	super setName: aResourceName.
	amountAvailable :=  amount! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

ResourceProvider class
	instanceVariableNames: ''!


!ResourceProvider class methodsFor: 'instance creation'!

named: aResourceName
	^self new setName: aResourceName with: 0!

named: aResourceName with: amount
	^self new setName: aResourceName with: amount! !
