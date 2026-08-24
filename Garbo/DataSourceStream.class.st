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

{ #category : 'accessing' }
DataSourceStream class >> neoJsonMapping: mapper [

	mapper for: self customDo: [ :mapping |
			mapping encoder: [ :dataSource |
					| dict |
					dict := Dictionary new.
					dict at: #type put: dataSource class name asString.
					self allInstVarNames do: [ :ivName | dict at: ivName asSymbol put: (dataSource instVarNamed: ivName) ].
					dict ].
			mapping decoder: [ :dict |
					| cls instance |
					cls := Smalltalk at: (dict at: #type) asSymbol.
					instance := cls new.
					self allInstVarNames do: [ :ivName | instance instVarNamed: ivName put: (dict at: ivName asSymbol ifAbsent: [ nil ]) ].
					instance ] ]
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
