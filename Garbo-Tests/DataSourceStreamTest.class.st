Class {
	#name : 'DataSourceStreamTest',
	#superclass : 'TestCase',
	#category : 'Garbo-Tests',
	#package : 'Garbo-Tests'
}

{ #category : 'setup' }
DataSourceStreamTest >> circularDataSource [

	^ CircularDataSourceStream source: self dictionaryTransformer sampleSize: 1
]

{ #category : 'tests' }
DataSourceStreamTest >> completeDataset [
^
'h1,h2,h3
2026-07-31T16:07:26,1,4
2026-07-31T17:47:26,-3,3
2026-07-31T16:47:26,-2,2
2026-07-31T17:07:26,3,3
'
]

{ #category : 'setup' }
DataSourceStreamTest >> dictionaryStream [

	^ CSV2DictionaryStream source: self completeDataset readStream
]

{ #category : 'setup' }
DataSourceStreamTest >> dictionaryTransformer [

	^ (DictionaryTransformerStream source: self dictionaryStream)
		  addKey: #h2 transformationBlock: (SourcedCleanBlockClosure for: '[ :val | (Number readFrom: val) + 1 ]');
		  addKey: #h3 transformationBlock: (SourcedCleanBlockClosure for: '[ :val | val , '' ! '' ]');
		  yourself
]

{ #category : 'setup' }
DataSourceStreamTest >> linearDataSource [

	^ LinearDataSourceStream source: self dictionaryTransformer sampleSize: 1
]

{ #category : 'setup' }
DataSourceStreamTest >> linearFileDataSource [

^'{
	"sampleSize" : 1,
	"source" : {
	   "filename" : "garboTest1.json"
		"transformerBlocks" : {
			"h2" : "[ :val | (Number readFrom: val) + 1 ]",
			"h3" : "[ :val | val , '' ! '' ]"
		}
	},
	"position" : 0,
	"type" : "LinearDataSourceStream"
}'
]

{ #category : 'setup' }
DataSourceStreamTest >> linearStringDataSource [

^'{
	"instVars" : {
		"source" : {
			"transformerBlocks" : {
				"h2" : "[ :val | (Number readFrom: val) + 1 ]",
				"h3" : "[ :val | val , '' ! '' ]"
			},
			"source" : {
				"value" : "h1,h2,h3\r2026-07-31T16:07:26,1,4\r2026-07-31T17:47:26,-3,3\r2026-07-31T16:47:26,-2,2\r2026-07-31T17:07:26,3,3\r",
				"type" : "String"
			}
		},
		"position" : 0,
		"sampleSize" : 1
	},
	"type" : "LinearDataSourceStream"
}'
]

{ #category : 'tests' }
DataSourceStreamTest >> testLinearJsonExport [

	| lds |
	lds := self linearDataSource.

	(NeoJSONWriter toStringPretty: lds) inspect

	"self assert: (NeoJSONWriter toStringPretty: d1) notNil & ((NeoJSONWriter toStringPretty: d1) size = self jsonGarbo1Spec size)."
]

{ #category : 'tests' }
DataSourceStreamTest >> testLinearJsonInport [

	| dataSourceStream |
	dataSourceStream := NeoJSONReader  on: self linearStringDataSource readStream .
	

	(dataSourceStream nextAs:LinearDataSourceStream)  inspect
]
