Class {
	#name : #CSNModelImporterGXTContainerVisitor,
	#superclass : #CSNModelImporterVisitor,
	#traits : 'CSNTWithPrefix',
	#classTraits : 'CSNTWithPrefix classTrait',
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #'instance creation' }
CSNModelImporterGXTContainerVisitor >> createAttribute: aAttributeClass for: attributeElement [
	^ (self create: aAttributeClass)
		name: attributeElement name;
		attributeValue: attributeElement value asLowercase;
		widget: entity;
		yourself
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> createLayout: aLayoutClass for: sourceCode [
	^ (self create: aLayoutClass)
		source: sourceCode;
		name: sourceCode name;
		yourself
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> createWidget: aWidgetClass for: widgetElement [
	^ (self create: aWidgetClass)
		source: widgetElement;
		name: widgetElement name;
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
