Class {
	#name : #CSNModelImporterGXTMenuVisitor,
	#superclass : #CSNModelImporterAbstractGWTVisitor,
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #initialization }
CSNModelImporterGXTMenuVisitor >> initialize [
	super initialize.
	prefix := 'menu:'.
]

{ #category : #visitor }
CSNModelImporterGXTMenuVisitor >> visit: anElement [
	^ anElement accept: self
]

{ #category : #visitor }
CSNModelImporterGXTMenuVisitor >> visitCSNUIMenu: aCSNUIMenu [
	^ source name = (self prefix , 'Menu') ifTrue: [ self createWidget: aCSNUIMenu for: source ] ifFalse: [ ^ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTMenuVisitor >> visitCSNUIMenuItem: aCSNUIMenuItem [
	^ source name = (self prefix , 'MenuItem') ifTrue: [ self createWidget: aCSNUIMenuItem for: source ] ifFalse: [ ^ nil ]
]
