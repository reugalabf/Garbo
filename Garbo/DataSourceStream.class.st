Class {
	#name : 'DataSourceStream',
	#superclass : 'Object',
	#instVars : [
		'filename',
		'position'
	],
	#category : 'Garbo-Core',
	#package : 'Garbo',
	#tag : 'Core'
}

{ #category : 'accessing' }
DataSourceStream >> dataSource [

	^ CSV2DictionaryStream source: filename asFileReference readStream
]

{ #category : 'initialization' }
DataSourceStream >> filename: aString position: index [

	filename := aString.
	position := index.
	^ self
]

{ #category : 'initialization' }
DataSourceStream >> initialize [

	position := 0.
	^ self
]
