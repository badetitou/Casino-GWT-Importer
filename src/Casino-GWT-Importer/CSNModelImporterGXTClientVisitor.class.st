Class {
	#name : #CSNModelImporterGXTClientVisitor,
	#superclass : #CSNModelImporterVisitor,
	#traits : 'CSNTWithPrefix',
	#classTraits : 'CSNTWithPrefix classTrait',
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #'instance creation' }
CSNModelImporterGXTClientVisitor >> createAttributeFor: attributeElement [
	^ (self create: self)
		name: attributeElement name;
		attributeValue: attributeElement value asLowercase;
		widget: attributeElement;
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
