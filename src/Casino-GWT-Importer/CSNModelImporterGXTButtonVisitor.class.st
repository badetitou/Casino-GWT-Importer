Class {
	#name : #CSNModelImporterGXTButtonVisitor,
	#superclass : #CSNModelImporterVisitor,
	#traits : 'CSNTWithPrefix',
	#classTraits : 'CSNTWithPrefix classTrait',
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #'instance creation' }
CSNModelImporterGXTButtonVisitor >> createAttributeFor: attributeElement [
	^ (self create: self)
		name: attributeElement name;
		attributeValue: attributeElement value asLowercase;
		widget: attributeElement;
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
