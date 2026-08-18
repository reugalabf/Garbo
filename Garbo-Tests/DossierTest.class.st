Class {
	#name : 'DossierTest',
	#superclass : 'TestCase',
	#category : 'Garbo-Tests',
	#package : 'Garbo-Tests'
}

{ #category : 'tests' }
DossierTest >> completeDataset [
^
'h1,h2,h3
2026-07-31T16:07:26,1,4
2026-07-31T17:47:26,-3,3
2026-07-31T16:47:26,-2,2
2026-07-31T17:07:26,3,3
'
]

{ #category : 'as yet unclassified' }
DossierTest >> dictionaryStream [

	^ CSV2DictionaryStream source: self completeDataset readStream
]

{ #category : 'as yet unclassified' }
DossierTest >> dictionaryTransformer [

	^ (DictionaryTransformerStream source: self dictionaryStream)
		  addKey: #h2 transformationBlock: (SourcedCleanBlockClosure for: '[ :val | (Number readFrom: val) + 1 ]');
		  addKey: #h3 transformationBlock: (SourcedCleanBlockClosure for: '[ :val | val , '' ! '' ]');
		  yourself
]

{ #category : 'as yet unclassified' }
DossierTest >> dictionaryTransformerOne [

	^ (DictionaryTransformerStream source: self dictionaryStream)
		  addKey: #h2 transformationBlock: (SourcedCleanBlockClosure for: '[ :val | (Number readFrom: val) + 1 ]');
		  yourself
]

{ #category : 'as yet unclassified' }
DossierTest >> jsonSpec1 [

	^ '{
	"name" : "Garbo1",
	"dataSource" : {
		"source" : {
			"transformerBlocks" : {
				"h2" : "[ :val | (Number readFrom: val) + 1 ]",
				"h3" : "[ :val | val , '' ! '' ]"
			}
		},
		"sampleSize" : 1,
		"position" : 0
	},
	"tradecraft" : {
		"report" : "no report",
		"writer" : {
			"type" : "NullReportWriter"
		},
		"type" : "DeadDrop"
	}
}'
]

{ #category : 'as yet unclassified' }
DossierTest >> jsonSpecTransformer [

	^ '{
	"transformerBlocks" : {
		"h2" : "[ :val | (Number readFrom: val) + 1 ]"
	}
}'
]

{ #category : 'tests' }
DossierTest >> testDictionaryTransformerExport [

	| object |
	object := self dictionaryTransformerOne.
	self assert: (NeoJSONWriter toStringPretty: object) size = self jsonSpecTransformer size
]

{ #category : 'tests' }
DossierTest >> testDossierEmptyDataSourceExport [

	| d1 |
	d1 := Dossier new.
	d1
		name: 'Garbo1';
		tradecraft: (DeadDrop new writer: NullReportWriter new);
		dataSource: (DataSourceStream source: self dictionaryTransformer sampleSize: 1).

	self assert: (NeoJSONWriter toStringPretty: d1) notNil & ((NeoJSONWriter toStringPretty: d1) size = self jsonSpec1 size)
]
