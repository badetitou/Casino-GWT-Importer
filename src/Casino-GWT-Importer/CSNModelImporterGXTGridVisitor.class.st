Class {
	#name : #CSNModelImporterGXTGridVisitor,
	#superclass : #CSNModelImporterVisitor,
	#traits : 'CSNTWithPrefix',
	#classTraits : 'CSNTWithPrefix classTrait',
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #'instance creation' }
CSNModelImporterGXTGridVisitor >> createAttribute: anAttribute for: attributeElement [
	^ (self create: anAttribute)
		name: attributeElement name;
		attributeValue: attributeElement value asLowercase;
		yourself
]

{ #category : #visitor }
CSNModelImporterGXTGridVisitor >> createWidget: aWidgetClass for: widgetElement [
	^ (self create: aWidgetClass)
		source: widgetElement;
		name: widgetElement name;
		yourself
]

{ #category : #initialization }
CSNModelImporterGXTGridVisitor >> initialize [
	super initialize.
	prefix := 'grid:'.
]

{ #category : #visitor }
CSNModelImporterGXTGridVisitor >> visit: anElement [
	^ anElement accept: self
]