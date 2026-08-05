Class {
	#name : 'DossierTest',
	#superclass : 'TestCase',
	#category : 'Garbo-Tests',
	#package : 'Garbo-Tests'
}

{ #category : 'tests' }
DossierTest >> testDossier1 [

	| d1 |
	d1 := Dossier new.
	d1
		name: 'Garbo1';
		tradecraft: (DeadDrop new writer: NullReportWriter new);
		dataSource: (DataSourceStream new filename: 'aString' sampleSize: 2).
	"d1 inspect."
	self assert: (NeoJSONWriter toStringPretty: d1) notNil
]
