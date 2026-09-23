Extension { #name : 'DictionaryTransformerStream' }

{ #category : '*Garbo' }
DictionaryTransformerStream class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping |
			(mapping mapInstVar: #transformerBlocks) valueSchema: #ArrayOfBlocks.
			(mapping mapInstVar: #source) valueSchema: #CSV2DictionaryStreamSchema ].

	mapper for: #ArrayOfBlocks customDo: [ :mapping | mapping mapWithValueSchema: #BlockSchema ].

	mapper for: #BlockSchema customDo: [ :mapping |
			mapping
				encoder: [ :aBlock | aBlock sourceCode ];
				decoder: [ :sourceString | SourcedCleanBlockClosure for: sourceString ] ].

	mapper for: #CSV2DictionaryStreamSchema customDo: [ :mapping |
			mapping
				encoder: [ :aCVS2DictStream |
						| dict |
						dict := Dictionary new.
						aCVS2DictStream isFileSource
							ifTrue: [ "aCVS2DictStream getDataSource  inspect "
									dict at: #type put: #File.
									dict at: #value put: aCVS2DictStream getDataSource ]
							ifFalse: [ "aCVS2DictStream  inspect.""(mapper -> mapping -> aCVS2DictStream) inspect"
									dict at: #type put: #String.
									dict at: #value put: aCVS2DictStream getDataSource ].
						dict ];
				decoder: [ :properties | "(#sourceString -> properties) inspect"
						(properties at: #type) = #File
							ifTrue: [ CSV2DictionaryStream source: ( ((properties at: #value) asFileReference readStream)) .
								"(#File -> (properties at: #value)) inspect" ]
							ifFalse: [ CSV2DictionaryStream source: (properties at: #value) readStream ] ] ]
]
