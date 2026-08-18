Class {
	#name : 'SourcedCleanBlockClosure',
	#superclass : 'Object',
	#instVars : [
		'source',
		'block'
	],
	#category : 'Garbo-Utility',
	#package : 'Garbo',
	#tag : 'Utility'
}

{ #category : 'accessing' }
SourcedCleanBlockClosure class >> for: aString [

	^ self source: aString
]

{ #category : 'accessing' }
SourcedCleanBlockClosure class >> source: aString [

	^ self new compileAndInitializeWith: aString
]

{ #category : 'compiling' }
SourcedCleanBlockClosure >> compileAndInitializeWith: aString [

	| result |
	"
	[ result := Smalltalk compiler evaluate: aString ]
		on: Error
		do: [ :ex | ex inspect ]"
	result := Smalltalk compiler evaluate: aString.
	^ result isBlock & result isClean & (result argumentCount = 1)
		  ifTrue: [
				  source := aString.
				  block := result.
				  self ]
		  ifFalse: [ self error: 'Malformed block. An one argument CleanBlockClosure expected' ]
]

{ #category : 'evaluating' }
SourcedCleanBlockClosure >> cull: anObject [

	^ block cull: anObject
]

{ #category : 'compiling' }
SourcedCleanBlockClosure >> sourceCode [
	^ source
]

{ #category : 'evaluating' }
SourcedCleanBlockClosure >> value: anObject [

	^ block value: anObject
]
