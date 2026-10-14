Class {
	#name : 'JSONReportWriter',
	#superclass : 'ReportWriter',
	#category : 'Garbo-Core',
	#package : 'Garbo',
	#tag : 'Core'
}

{ #category : 'accessing' }
JSONReportWriter class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping |  ]
]

{ #category : 'reporting' }
JSONReportWriter >> convert: aDictionaryCollection [

	^ String streamContents: [ :stream |
			  (NeoJSONWriter on: stream)
				  prettyPrint: true;
				  nextPut: aDictionaryCollection ]
]
