Class {
	#name : 'Tradecraft',
	#superclass : 'Object',
	#instVars : [
		'writer'
	],
	#category : 'Garbo-Core',
	#package : 'Garbo',
	#tag : 'Core'
}

{ #category : 'accessing' }
Tradecraft class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping |
			(mapping mapInstVar: #writer) valueSchema: #ObjectSchema. ].
		
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

{ #category : 'announcing' }
Tradecraft >> deliver: aDictionary [

	self subclassResponsibility
]

{ #category : 'accessing' }
Tradecraft >> writer [

	^ writer
]

{ #category : 'accessing' }
Tradecraft >> writer: anObject [

	writer := anObject
]
