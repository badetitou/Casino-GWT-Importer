Trait {
	#name : #CSNTWithPrefix,
	#instVars : [
		'prefix'
	],
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #accessing }
CSNTWithPrefix >> prefix [
	^ prefix ifNil: [ prefix := '' ]
]

{ #category : #accessing }
CSNTWithPrefix >> prefix: anObject [
	prefix := anObject
]
