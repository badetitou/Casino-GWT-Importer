Class {
	#name : #CSNModelImporterGWTClientVisitor,
	#superclass : #CSNModelImporterAbstractGWTVisitor,
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #visitor }
CSNModelImporterGWTClientVisitor >> initialize [
	super initialize.
	prefix := 'g:'.
]

{ #category : #visitor }
CSNModelImporterGWTClientVisitor >> visit: anElement [
	^ anElement accept: self
]
