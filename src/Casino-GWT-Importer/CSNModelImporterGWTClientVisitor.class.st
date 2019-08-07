Class {
	#name : #CSNModelImporterGWTClientVisitor,
	#superclass : #CSNModelImporterVisitor,
	#traits : 'CSNTWithPrefix',
	#classTraits : 'CSNTWithPrefix classTrait',
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #'instance creation' }
CSNModelImporterGWTClientVisitor >> createAttributeFor: attributeElement [
	^ (self create: self)
		name: attributeElement name;
		attributeValue: attributeElement value asLowercase;
		widget: attributeElement;
		yourself
]

{ #category : #visitor }
CSNModelImporterGWTClientVisitor >> createWidget: aWidgetClass for: widgetElement [
	^ (self create: aWidgetClass)
		source: widgetElement;
		name: widgetElement name;
		yourself
]

{ #category : #visitor }
CSNModelImporterGWTClientVisitor >> initialize [
	super initialize.
	prefix := 'g:'.
]

{ #category : #visitor }
CSNModelImporterGWTClientVisitor >> visit: anElement [
	^ anElement accept: self
]