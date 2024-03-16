'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:14:35 pm'!

SimulationObject subclass: #EventMonitor
	instanceVariableNames: 'label '
	classVariableNames: 'Counter DataFile '
	poolDictionaries: ''
	category: 'Simulation statistics gathering'!


!EventMonitor methodsFor: 'scheduling'!

finishUp
	super finishUp.
	self timeStamp.
	DataFile nextPutAll: ' exits '.!

startUp
	self timeStamp.
	DataFile nextPutAll: ' enters '.
	super startUp! !

!EventMonitor methodsFor: 'task language'!

acquire: amount ofResource: resourceName
	| aStaticResource |
	self timeStamp.
	DataFile nextPutAll: ' requests '.
	amount printOn: DataFile.
	DataFile nextPutAll: ' of ', resourceName.
	aStaticResource :=  super acquire: amount ofResource: resourceName.
	self timeStamp.
	DataFile nextPutAll: ' obtained '.
	amount printOn: DataFile.
	DataFile nextPutAll: ' of ', resourceName.
	^aStaticResource!

acquire: amount ofResource: resourceName withPriority: priorityNumber
	| aStaticResource |
	self timeStamp.
	DataFile nextPutAll: ' requests '.
	amount printOn: DataFile.
	DataFile nextPutAll: ' at priority '.
	priorityNumber printOn: DataFile.
	DataFile nextPutAll: ' of ', resourceName.
	aStaticResource :=  super acquire: amount ofResource: resourceName withPriority: priorityNumber.
	self timeStamp.
	DataFile nextPutAll: ' obtained '.
	amount printOn: DataFile.
	DataFile nextPutAll: ' of ', resourceName.
	^aStaticResource!

acquireResource: resourceName
	| anEvent |
	self timeStamp.
	DataFile nextPutAll: ' wants to serve for '.
	DataFile nextPutAll: resourceName.
	anEvent :=  super acquireResource: resourceName.
	self timeStamp.
	DataFile nextPutAll: ' can serve '.
	anEvent resource printOn: DataFile.
	^anEvent!

holdFor: aTimeDelay
	self timeStamp.
	DataFile nextPutAll: ' holds for '.
	aTimeDelay printOn: DataFile.
	super holdFor: aTimeDelay!

produce: amount ofResource: resourceName
	self timeStamp.
	DataFile nextPutAll: ' produces '.
	amount printOn: DataFile.
	DataFile nextPutAll: ' of ', resourceName.
	super produce: amount ofResource: resourceName!

produceResource: resourceName
	self timeStamp.
	DataFile nextPutAll: ' wants to get service as '.
	DataFile nextPutAll: resourceName.
	super produceResource: resourceName!

release: aStaticResource
	self timeStamp.
	DataFile nextPutAll: ' releases '.
	aStaticResource amount printOn: DataFile.
	DataFile nextPutAll: ' of ', aStaticResource name.
	super release: aStaticResource!

resume: anEvent
	self timeStamp.
	DataFile nextPutAll: ' resumes '.
	anEvent resource printOn: DataFile.
	super resume: anEvent! !

!EventMonitor methodsFor: 'private'!

timeStamp
	DataFile cr.
	Simulation active time printOn: DataFile.
	DataFile tab.
	self printOn: DataFile! !

!EventMonitor methodsFor: 'initialization'!

initialize
	super initialize.
	self setLabel! !

!EventMonitor methodsFor: 'accessing'!

label
	^label!

setLabel
	Counter :=  Counter + 1.
	label :=  Counter printString.! !

!EventMonitor methodsFor: 'printing'!

printOn: aStream
	self class name printOn: aStream.
	aStream space.
	aStream nextPutAll: self label! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

EventMonitor class
	instanceVariableNames: ''!


!EventMonitor class methodsFor: 'class initialization'!

file: aFile
	DataFile :=  aFile.
	Counter :=  0! !
