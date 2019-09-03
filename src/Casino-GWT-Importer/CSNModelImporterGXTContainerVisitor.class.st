Class {
	#name : #CSNModelImporterGXTContainerVisitor,
	#superclass : #CSNModelImporterAbstractGWTVisitor,
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> createLayout: aLayoutClass for: sourceCode [
	^ (self create: aLayoutClass)
		source: sourceCode;
		name: sourceCode name;
		yourself
]

{ #category : #initialization }
CSNModelImporterGXTContainerVisitor >> initialize [
	super initialize.
	prefix := 'container:'.
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visit: anElement [
	^ anElement accept: self
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visitCSNLBorderLayout: aCSNLBorderLayout [
	^ source name = (self prefix , 'BorderLayoutContainer') ifTrue: [ self createLayout: aCSNLBorderLayout for: source ] ifFalse: [ ^ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visitCSNLVerticalLayout: aCSNLVerticalLayout [
	^ source name = (self prefix , 'VerticalLayoutContainer') ifTrue: [ self createLayout: CSNLVerticalLayout for: source ] ifFalse: [ ^ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visitCSNUIFieldset: aCSNUIFieldset [
	^ nil
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visitCSNUIPanel: aCSNUIPanel [
	^ ((source name beginsWith: self prefix) and: [ source name endsWith: 'Container']) ifTrue: [ | panel | 
		panel := self createWidget: aCSNUIPanel for: source.
		panel layout: (self factory createLayoutFor: source withParent: panel ) ] ifFalse: [ ^ nil ]
]
