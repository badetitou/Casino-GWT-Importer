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

{ #category : #visitor }
CSNModelImporterGWTClientVisitor >> visitCSNUIImage: aCSNUIImage [
	^ source name = (self prefix , 'Image') ifTrue: [ self createWidget: aCSNUIImage for: source ] ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGWTClientVisitor >> visitCSNUIParagraph: aCSNUIParagraph [
	^ source name = (self prefix , 'Label') ifTrue: [ self createWidget: aCSNUIParagraph for: source ] ifFalse: [ nil ]
]
