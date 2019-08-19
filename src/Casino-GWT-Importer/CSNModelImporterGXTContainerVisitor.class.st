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
CSNModelImporterGXTContainerVisitor >> visitCSNUIFieldset: aCSNUIFieldset [
	^ nil
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visitCSNUIPanel: aCSNUIPanel [
	^ (source name = (self prefix, 'VerticalLayoutContainer')) ifTrue: [ | panel | 
		panel := self createWidget: aCSNUIPanel for: source.
		panel layout: (self create: CSNLVerticalLayout) ] ifFalse: [ ^ nil ]
]
