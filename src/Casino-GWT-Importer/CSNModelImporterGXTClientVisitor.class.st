Class {
	#name : #CSNModelImporterGXTClientVisitor,
	#superclass : #CSNModelImporterVisitor,
	#traits : 'CSNTWithPrefix',
	#classTraits : 'CSNTWithPrefix classTrait',
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #visitor }
CSNModelImporterGXTClientVisitor >> createAttribute: aAttributeClass for: attributeElement [
	^ (self create: aAttributeClass)
		name: attributeElement name;
		attributeValue: attributeElement value asLowercase;
		widget: entity;
		yourself
]

{ #category : #visitor }
CSNModelImporterGXTClientVisitor >> createWidget: aWidgetClass for: widgetElement [
	^ (self create: aWidgetClass)
		source: widgetElement;
		name: widgetElement name;
		yourself
]

{ #category : #initialization }
CSNModelImporterGXTClientVisitor >> initialize [
	super initialize.
	prefix := 'gxt:'.
]

{ #category : #visitor }
CSNModelImporterGXTClientVisitor >> visit: anElement [
	^ anElement accept: self
]

{ #category : #visitor }
CSNModelImporterGXTClientVisitor >> visitCSNUIFieldset: aCSNUIFieldset [
	^ source name = (self prefix , 'Window')
		ifTrue: [ self createWidget: aCSNUIFieldset for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTClientVisitor >> visitCSNUITitle: aCSNUITitle [
	^ (source name = 'headingText') ifTrue: [ self createAttribute: CSNUITitle for: source ] ifFalse: [ nil ]
]
