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

{ #category : 'accessing' }
DeadDrop class >> neoJsonMapping: mapper [

	super neoJsonMapping: mapper.
	mapper for: self do: [ :mapping | mapping mapInstVars: #( report ) ]
]

{ #category : 'announcing' }
DeadDrop >> deliver: aDictionary [

	report := writer convert: aDictionary
]
