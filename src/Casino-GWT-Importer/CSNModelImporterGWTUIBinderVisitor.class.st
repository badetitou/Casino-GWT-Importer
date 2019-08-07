Class {
	#name : #CSNModelImporterGWTUIBinderVisitor,
	#superclass : #CSNModelImporterVisitor,
	#traits : 'CSNTWithPrefix',
	#classTraits : 'CSNTWithPrefix classTrait',
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #'instance creation' }
CSNModelImporterGWTUIBinderVisitor >> createAttributeFor: attributeElement [
	^ (self create: self)
		name: attributeElement name;
		attributeValue: attributeElement value asLowercase;
		widget: attributeElement;
		yourself
]

{ #category : #visitor }
CSNModelImporterGWTUIBinderVisitor >> createWidget: aWidgetClass for: widgetElement [
	^ (self create: aWidgetClass)
		source: widgetElement;
		name: widgetElement name;
		yourself
]

{ #category : #visitor }
CSNModelImporterGWTUIBinderVisitor >> initialize [
	super initialize.
	prefix := 'ui:'.
]

{ #category : #visitor }
CSNModelImporterGWTUIBinderVisitor >> visit: anElement [
	^ anElement accept: self
]
