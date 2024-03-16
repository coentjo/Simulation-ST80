'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:14:41 pm'!

Object subclass: #Histogram
	instanceVariableNames: 'tallyArray lowerBound upperBound step minValue maxValue totalValues extraEntries '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Simulation statistics gathering'!


!Histogram methodsFor: 'accessing'!

contains: aValue
	^lowerBound <= aValue and: [aValue < upperBound]!

store: aValue 
	| index |
	minValue isNil
		ifTrue: [minValue :=  maxValue _ aValue]
		ifFalse: 
			[minValue :=  minValue min: aValue.
			maxValue :=  maxValue max: aValue].
	totalValues :=  totalValues + aValue.
	(self contains: aValue)
		ifTrue: 
			[index :=  (aValue - lowerBound // step) + 1.
			tallyArray at: index put: (tallyArray at: index) + 1]
		ifFalse: [extraEntries :=  extraEntries + 1]! !

!Histogram methodsFor: 'printing'!

firstHeader: aStream
	aStream cr; tab.
	aStream nextPutAll: 'Number of '.
	aStream tab.
	aStream nextPutAll: 'Minimum '.
	aStream tab.
	aStream nextPutAll: 'Maximum '.
	aStream tab.
	aStream nextPutAll: 'Average '.
	aStream cr; tab.
	aStream nextPutAll: 'Objects '.
	aStream tab.
	aStream nextPutAll: 'Value '.
	aStream tab.
	aStream nextPutAll: 'Value '.
	aStream tab.
	aStream nextPutAll: 'Value '.!

printStatisticsOn: aStream 
	| totalObjs pos |
	self firstHeader: aStream.
	aStream cr; tab.
	totalObjs :=  extraEntries.
	tallyArray do: [:each | totalObjs :=  totalObjs + each].
	totalObjs printOn: aStream.
	aStream tab.
	minValue printOn: aStream.
	aStream tab.
	maxValue printOn: aStream.
	aStream tab.
	(totalValues / totalObjs) asFloat printOn: aStream.
	aStream cr.
	self secondHeader: aStream.
	aStream cr.
	pos :=  lowerBound.
	tallyArray do: 
		[:entry | 
		pos printOn: aStream.
		aStream nextPut: $-.
		(pos :=  pos + step) printOn: aStream.
		aStream tab.
		entry printOn: aStream.
		aStream tab.
		(entry / totalObjs) asFloat printOn: aStream.
		aStream tab.
		aStream nextPut: $|.
		entry rounded timesRepeat: [aStream nextPut: $X].
		aStream cr]!

secondHeader: aStream
	aStream cr; tab.
	aStream nextPutAll: 'Number of '.
	aStream cr.
	aStream nextPutAll: 'Entry '.
	aStream tab.
	aStream nextPutAll: 'Objects '.
	aStream tab.
	aStream nextPutAll: 'Frequency '.! !

!Histogram methodsFor: 'private'!

newLower: lowerNum upper: upperNum by: stepAmount
	tallyArray :=  Array new: (upperNum - lowerNum // stepAmount).
	tallyArray atAllPut: 0.
	lowerBound :=  lowerNum.
	upperBound :=  upperNum.
	step :=  stepAmount.
	minValue :=  maxValue _ nil.
	totalValues :=  0.
	extraEntries :=  0! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Histogram class
	instanceVariableNames: ''!


!Histogram class methodsFor: 'class initialization'!

from: lowerNum to: upperNum by: step
	^self new newLower: lowerNum upper: upperNum by: step! !
