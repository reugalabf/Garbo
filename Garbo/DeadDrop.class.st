Class {
	#name : 'DeadDrop',
	#superclass : 'Tradecraft',
	#instVars : [
		'report'
	],
	#category : 'Garbo-Core',
	#package : 'Garbo',
	#tag : 'Core'
}

{ #category : 'announcing' }
DeadDrop >> deliver: aDictionary [

	report := writer convert: aDictionary
]
