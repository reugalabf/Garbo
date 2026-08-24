Class {
	#name : 'DataSourceStreamTest',
	#superclass : 'TestCase',
	#category : 'Garbo-Tests',
	#package : 'Garbo-Tests'
}

{ #category : 'as yet unclassified' }
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

{ #category : 'as yet unclassified' }
DataSourceStreamTest >> linearDataSource [

	^ LinearDataSourceStream source: self dictionaryTransformer sampleSize: 1
]

{ #category : 'tests' }
DataSourceStreamTest >> testLinearJson [

	| lds |
	lds := self linearDataSource.
(	NeoJSONWriter toStringPretty: lds) inspect

	"self assert: (NeoJSONWriter toStringPretty: d1) notNil & ((NeoJSONWriter toStringPretty: d1) size = self jsonGarbo1Spec size).
"
]
