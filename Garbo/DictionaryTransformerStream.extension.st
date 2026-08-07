Extension { #name : 'DictionaryTransformerStream' }

{ #category : '*Garbo' }
DictionaryTransformerStream class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping | (mapping mapInstVar: #transformerBlocks) valueSchema: #ArrayOfBlocks ].

	mapper for: #ArrayOfBlocks customDo: [ :mapping | mapping mapWithValueSchema: #BlockSchema ].

	mapper for: #BlockSchema customDo: [ :mapping |
			mapping
				encoder: [ :aBlock |
						aBlock compiledBlock inspect.
						aBlock compiledBlock ast sourceCode ];
				decoder: [ :sourceString | Smalltalk compiler evaluate: sourceString ] ]
]
