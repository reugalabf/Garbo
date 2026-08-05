Class {
	#name : 'JSONReportWriter',
	#superclass : 'ReportWriter',
	#category : 'Garbo-Core',
	#package : 'Garbo',
	#tag : 'Core'
}

{ #category : 'reporting' }
JSONReportWriter >> convert: aDictionaryCollection [

	^ String streamContents: [ :stream |
			  (NeoJSONWriter on: stream)
				  prettyPrint: true;
				  nextPut: aDictionaryCollection ]
]
