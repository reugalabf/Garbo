Class {
	#name : 'DataSourceStream',
	#superclass : 'Object',
	#instVars : [
		'filename',
		'sampleSize',
		'position'
	],
	#category : 'Garbo-Core',
	#package : 'Garbo',
	#tag : 'Core'
}

{ #category : 'accessing' }
DataSourceStream class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping | mapping mapInstVars: #( filename sampleSize position ) ]
]

{ #category : 'accessing' }
DataSourceStream >> dataSource [

	^ CSV2DictionaryStream source: filename asFileReference readStream
]

{ #category : 'initialization' }
DataSourceStream >> filename: aString position: index sampleSize: anInteger [

	sampleSize := anInteger.
	filename := aString.
	position := index.
	^ self
]

{ #category : 'initialization' }
DataSourceStream >> filename: aString  sampleSize: anInteger [

	sampleSize := anInteger.
	filename := aString.
	position := 0.
	^ self
]

{ #category : 'initialization' }
DataSourceStream >> initialize [

	position := 0.
	
	^ self
]
