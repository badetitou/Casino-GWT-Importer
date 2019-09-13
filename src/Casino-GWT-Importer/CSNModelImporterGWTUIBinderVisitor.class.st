Class {
	#name : #CSNModelImporterGWTUIBinderVisitor,
	#superclass : #CSNModelImporterAbstractGWTVisitor,
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #visitor }
CSNModelImporterGWTUIBinderVisitor >> initialize [
	super initialize.
	prefix := 'ui:'.
]

{ #category : #visitor }
CSNModelImporterGWTUIBinderVisitor >> visit: anElement [
	^ anElement accept: self
]

{ #category : #visitor }
CSNModelImporterGWTUIBinderVisitor >> visitCSNLeaf: aCSNLeaf [
	^ (({(self prefix , 'with'). (self prefix , 'UiBinder')}) includes: source name)
		ifTrue: [ ^ CSNDummyLeaf new ]
		ifFalse: [ ^ nil ]
]
