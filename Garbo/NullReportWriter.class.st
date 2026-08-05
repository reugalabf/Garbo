Class {
	#name : 'NullReportWriter',
	#superclass : 'ReportWriter',
	#category : 'Garbo-Core',
	#package : 'Garbo',
	#tag : 'Core'
}

{ #category : 'accessing' }
NullReportWriter class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping |  ]
]

{ #category : 'reporting' }
NullReportWriter >> convert: aDictionaryCollection [

	^aDictionaryCollection 
]
