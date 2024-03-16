'From Objectworks for Smalltalk-80(tm), Version 2.5 of 29 July 1989 on 19 January 1990 at 1:12:48 pm'!

ContinuousProbability subclass: #Normal
	instanceVariableNames: 'mu sigma '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Statistics'!
Normal comment:
'How long before a success occurs or how many events occur in a certain time interval?'!


!Normal methodsFor: 'accessing'!

mean
	^mu!

variance
	^sigma squared! !

!Normal methodsFor: 'random sampling'!

next
	| v1 v2 s rand u |
	rand :=  Uniform from: -1.0 to: 1.0.
	[v1 :=  rand next.
	 v2 :=  rand next.
	 s :=  v1 squared + v2 squared.
	 s >= 1] whileTrue.
	u :=  (-2.0 * s ln /s) sqrt.
	^mu + (sigma * v1 *u)! !

!Normal methodsFor: 'probability functions'!

density: x

	| twoPi t |
	twoPi :=  2 * 3.1415926536.
	t :=  x - mu/sigma.
	^(-0.5 * t squared) exp / (sigma * twoPi sqrt)! !

!Normal methodsFor: 'private'!

setMean: m standardDeviation: s
	mu :=  m.
	sigma :=  s! !
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Normal class
	instanceVariableNames: ''!


!Normal class methodsFor: 'instance creation'!

mean: a deviation: b
	b > 0.0
	ifTrue: [^self new setMean: a standardDeviation: b]
	ifFalse: [self error: 'standard deviation must be greater than 0.0']! !
