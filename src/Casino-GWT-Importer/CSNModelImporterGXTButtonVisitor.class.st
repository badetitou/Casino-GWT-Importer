Class {
	#name : #CSNModelImporterGXTButtonVisitor,
	#superclass : #CSNModelImporterVisitor,
	#traits : 'CSNTWithPrefix',
	#classTraits : 'CSNTWithPrefix classTrait',
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #visitor }
CSNModelImporterGXTButtonVisitor >> createAttribute: aAttributeClass for: attributeElement [
	^ (self create: aAttributeClass)
		name: attributeElement name;
		attributeValue: attributeElement value asLowercase;
		widget: entity;
		yourself
]

{ #category : #visitor }
CSNModelImporterGXTButtonVisitor >> createWidget: aWidgetClass for: widgetElement [
	^ (self create: aWidgetClass)
		source: widgetElement;
		name: widgetElement name;
		yourself
]

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
	source name = 'text'
]
