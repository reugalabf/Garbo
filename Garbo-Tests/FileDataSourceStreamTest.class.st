Class {
	#name : 'FileDataSourceStreamTest',
	#superclass : 'TestCase',
	#instVars : [
		'specFile',
		'dataSetCSV'
	],
	#category : 'Garbo-Tests',
	#package : 'Garbo-Tests'
}

{ #category : 'resources' }
FileDataSourceStreamTest >> completeDatasetCSV [

	^ 'h1,h2,h3
2026-07-31T16:07:26,1,4
2026-07-31T16:47:26,-2,2
2026-07-31T17:07:26,3,3
2026-07-31T17:47:26,-3,3
'
]

{ #category : 'resources' }
FileDataSourceStreamTest >> dataSourceSpec [

^'{
	"instVars" : {
		"source" : {
			"transformerBlocks" : {
				"h2" : "[ :val | (Number readFrom: val) + 1 ]",
				"h3" : "[ :val | val , '' ! '' ]"
			},
			"source" : {
				"value" : "completeDataSource.csv",
				"type" : "File"
			}
		},
		"position" : 0,
		"sampleSize" : 1
	},
	"type" : "LinearDataSourceStream"
}'
]

{ #category : 'as yet unclassified' }
FileDataSourceStreamTest >> dataSourceSpecFilename [

	^ 'dataSourceSpec.json'
]

{ #category : 'running' }
FileDataSourceStreamTest >> setUp [

	specFile := self dataSourceSpecFilename asFileReference.
	specFile ensureDelete. "writeStreamDo: may not truncate an existing file"
	specFile writeStreamDo: [ :stream | stream nextPutAll: self dataSourceSpec ].

	dataSetCSV := 'completeDataSource.csv' asFileReference.
	dataSetCSV ensureDelete. "writeStreamDo: may not truncate an existing file"
	dataSetCSV writeStreamDo: [ :stream | stream nextPutAll: self completeDatasetCSV ]
]

{ #category : 'running' }
FileDataSourceStreamTest >> tearDown [

	specFile ensureDelete. "writeStreamDo: may not truncate an existing file"

	dataSetCSV ensureDelete "writeStreamDo: may not truncate an existing file"
]

{ #category : 'tests' }
FileDataSourceStreamTest >> testLoadingFromSpec [
	"specFile := self dataSourceSpecFilename asFileReference."

	| dataSourceStream |
	dataSourceStream := NeoJSONReader on: self dataSourceSpecFilename asFileReference readStream.


	(dataSourceStream nextAs: LinearDataSourceStream) inspect
]

{ #category : 'tests' }
FileDataSourceStreamTest >> testLoadingNext [
	"specFile := self dataSourceSpecFilename asFileReference."

	| jsonReader dataSourceStream |
	jsonReader := NeoJSONReader on: self dataSourceSpecFilename asFileReference readStream.


	dataSourceStream := jsonReader nextAs: LinearDataSourceStream.
	self assert: (dataSourceStream next first at: #h1) = '2026-07-31T16:07:26'.
	self assert: (dataSourceStream next first at: #h1) = '2026-07-31T16:47:26'.
	dataSourceStream next.
	self assert: (dataSourceStream next first at: #h1) = '2026-07-31T17:47:26'
]
