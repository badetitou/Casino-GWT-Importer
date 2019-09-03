Class {
	#name : #CSNModelImporterGXTGridVisitor,
	#superclass : #CSNModelImporterAbstractGWTVisitor,
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #initialization }
CSNModelImporterGXTGridVisitor >> initialize [
	super initialize.
	prefix := 'grid:'.
]

{ #category : #visitor }
CSNModelImporterGXTGridVisitor >> visit: anElement [
	^ anElement accept: self
]
