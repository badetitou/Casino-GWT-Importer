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
