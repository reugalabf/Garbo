Class {
	#name : 'LinearDataSourceStream',
	#superclass : 'DataSourceStream',
	#category : 'Garbo-Core',
	#package : 'Garbo',
	#tag : 'Core'
}

{ #category : 'stream-protocol' }
LinearDataSourceStream >> next [

	| result |
	result := OrderedCollection new.
	sampleSize timesRepeat: [ :idx |
			[ result add: source next ]
				on: Error
				do: [ nil ] ].
	^ result
]
