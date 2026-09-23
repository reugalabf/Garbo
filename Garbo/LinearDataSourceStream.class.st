Class {
	#name : 'LinearDataSourceStream',
	#superclass : 'DataSourceStream',
	#category : 'Garbo-Core',
	#package : 'Garbo',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LinearDataSourceStream class >> fromProperties: properties [

	| instance |
	instance := self new.


	instance instVarNamed: #sampleSize put: (properties at: #sampleSize).
	instance instVarNamed: #position put: (properties at: #position).
	instance
		instVarNamed: #source
		put: ((NeoJSONReader on: (NeoJSONWriter toString: (properties at: #source)) readStream) nextAs: DictionaryTransformerStream).

	^ instance
]

{ #category : 'accessing' }
LinearDataSourceStream class >> propertiesFrom: dataSource [
	"neoJsonMapping: mapper

	mapper for: self do: [ :mapping |
			mapping mapInstVars: { #sampleSize. #position }.
			(mapping mapInstVar: #source) valueSchema: DictionaryTransformerStream ]"

	| properties |
	properties := Dictionary new.
	properties at: #sampleSize put: (dataSource instVarNamed: #sampleSize).
	properties at: #position put: (dataSource instVarNamed: #position).
	properties at: #source put: (NeoJSONWriter toStringPretty: (dataSource instVarNamed: #source)).
	"properties inspect."
	^ properties
]

{ #category : 'stream-protocol' }
LinearDataSourceStream >> next [

	| result |
	result := OrderedCollection new.
	sampleSize timesRepeat: [
			[ result add: source next ]
				on: Error
				do: [ :ex | nil ] ].
	position := position + sampleSize.
	^ result
]
