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

{ #category : #visitor }
CSNModelImporterGXTGridVisitor >> visitCSNUITable: aCSNUITable [
	^ source name = (self prefix , 'Grid')
		ifTrue: [ self createWidget: aCSNUITable for: source ]
		ifFalse: [ nil ]
]
