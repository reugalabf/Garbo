Class {
	#name : 'DataSourceStream',
	#superclass : 'Object',
	#instVars : [
		'sampleSize',
		'position',
		'source'
	],
	#category : 'Garbo-Core',
	#package : 'Garbo',
	#tag : 'Core'
}

{ #category : 'instance creation' }
DataSourceStream class >> fromProperties: aDict [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
DataSourceStream class >> neoJsonMapping: mapper [

	mapper for: self customDo: [ :mapping |
			mapping encoder: [ :dataSource |
					| dict ws |
					"dataSource inspect."
					ws := WriteStream on: ''.
					dict := Dictionary new.
					dict at: #type put: dataSource class name asString.

					dict at: #instVars put: (self propertiesFrom: dataSource).
					"('DatasourceStream'-> dict)"
					dict ].
			mapping decoder: [ :dict |
					| cls |
					"(mapper -> mapping -> dict) inspect."
					cls := Smalltalk at: (dict at: #type) asSymbol.
					cls fromProperties: (dict at: #instVars)

					"					NeoJSONReader fromString: (String streamContents: [ :stream |
								 (NeoJSONWriter on: stream)
									 prettyPrint: true;
									 mapInstVarsFor: cls;
									 nextPut: (dict at: #instVars) ])" ] ]
]

{ #category : 'accessing' }
DataSourceStream class >> propertiesFrom: dataSource [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
DataSourceStream class >> source: aDictionaryStream sampleSize: anIntenger [

	^ self new
		  source: aDictionaryStream;
		  sampleSize: anIntenger;
		  yourself
]

{ #category : 'initialization' }
DataSourceStream >> initialize [

	position := 0.
	
	^ self
]

{ #category : 'stream-protocol' }
DataSourceStream >> next [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
DataSourceStream >> sampleSize: anObject [

	sampleSize := anObject
]

{ #category : 'accessing' }
DataSourceStream >> source: anObject [

	source := anObject
]
