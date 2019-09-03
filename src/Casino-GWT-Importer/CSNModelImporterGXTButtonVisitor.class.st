Class {
	#name : #CSNModelImporterGXTButtonVisitor,
	#superclass : #CSNModelImporterAbstractGWTVisitor,
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #initialization }
CSNModelImporterGXTButtonVisitor >> initialize [
	super initialize.
	prefix := 'button:'.
]

{ #category : #visitor }
CSNModelImporterGXTButtonVisitor >> visit: anElement [
	^ anElement accept: self
]

{ #category : #visitor }
CSNModelImporterGXTButtonVisitor >> visitCSNUIButton: aCSNUIButton [
	^ (source name = (self prefix, 'TextButton')) ifTrue: [ self createWidget: aCSNUIButton for: source ] ifFalse: [ ^ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTButtonVisitor >> visitCSNUILabel: aCSNUILabel [
	^ (source name = 'text') ifTrue: [ self createAttribute: aCSNUILabel for: source ] ifFalse: [ nil ]
]
