Class {
	#name : 'CSVReportWriter',
	#superclass : 'ReportWriter',
	#category : 'Garbo-Core',
	#package : 'Garbo',
	#tag : 'Core'
}

{ #category : 'reporting' }
CSVReportWriter >> convert: aDictionaryCollection [

	^ String streamContents: [ :stream |
			  | headers |
			  (NeoCSVWriter on: stream)
				  nextPut: (headers := aDictionaryCollection first keys);
				  addRawFieldsAt: headers;
				  nextPutAll: aDictionaryCollection ]
]
