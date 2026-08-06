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

	mapper for: self do: [ :mapping | mapping mapInstVars: #( "source" sampleSize position ) ]
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

{ #category : 'accessing' }
DataSourceStream >> sampleSize: anObject [

	sampleSize := anObject
]

{ #category : 'accessing' }
DataSourceStream >> source: anObject [

	source := anObject
]
