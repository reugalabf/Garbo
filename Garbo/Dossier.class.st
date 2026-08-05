"
|d1|
d1:=Dossier new.
d1 name: 'Garbo1';
tradecraft: ((DeadDrop new ) writer: (NullReportWriter new));
dataSource: (DataSourceStream new filename: 'aString' position: 0) .
d1 inspect.
(NeoJSONWriter toString: d1) inspect
"
Class {
	#name : 'Dossier',
	#superclass : 'Object',
	#instVars : [
		'name',
		'dataSource',
		'tradecraft'
	],
	#category : 'Garbo-Core',
	#package : 'Garbo',
	#tag : 'Core'
}

{ #category : 'accessing' }
Dossier class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping |
			mapping mapInstVars: #( name ).

			(mapping mapInstVar: #dataSource) valueSchema: DataSourceStream .
			(mapping mapInstVar: #tradecraft) valueSchema: #ObjectSchema ].
		
	mapper for: #ObjectSchema customDo: [ :mapping |
	mapping
		decoder: [ :json | | class |
			class := Smalltalk at: (json at: #type) asSymbol.
			(NeoJSONReader on: (NeoJSONWriter toString: json) readStream)
				mapClass: class;
				next ];
		encoder: [ :obj | | dict |
			dict := NeoJSONReader fromString: (NeoJSONWriter toString: obj).
			dict at: #type put: obj class name asString.
			dict ] ]	
]

{ #category : 'accessing' }
Dossier >> dataSource [

	^ dataSource
]

{ #category : 'accessing' }
Dossier >> dataSource: anObject [

	dataSource := anObject
]

{ #category : 'accessing' }
Dossier >> name [

	^ name
]

{ #category : 'accessing' }
Dossier >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
Dossier >> tradecraft [

	^ tradecraft
]

{ #category : 'accessing' }
Dossier >> tradecraft: anObject [

	tradecraft := anObject
]
