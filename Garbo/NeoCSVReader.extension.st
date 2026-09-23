Extension { #name : 'NeoCSVReader' }

{ #category : '*Garbo' }
NeoCSVReader >> getDataSource [

	^ readStream getDataSource 
]

{ #category : '*Garbo' }
NeoCSVReader >> isFileSource [

	^ readStream isKindOf: ZnEncodedStream
]
