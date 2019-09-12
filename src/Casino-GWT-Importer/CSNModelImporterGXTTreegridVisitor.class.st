Class {
	#name : #CSNModelImporterGXTTreegridVisitor,
	#superclass : #CSNModelImporterAbstractGWTVisitor,
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #initialization }
CSNModelImporterGXTTreegridVisitor >> initialize [
	super initialize.
	prefix := 'treegrid:'.
]

{ #category : #visitor }
CSNModelImporterGXTTreegridVisitor >> visit: anElement [
	^ anElement accept: self
]

{ #category : #visitor }
CSNModelImporterGXTTreegridVisitor >> visitCSNUITable: aCSNUITable [
	^ source name = (self prefix , 'TreeGrid')
		ifTrue: [ self createWidget: aCSNUITable for: source ]
		ifFalse: [ nil ]
]
