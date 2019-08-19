Class {
	#name : #CSNModelImporterGWTUIBinderVisitor,
	#superclass : #CSNModelImporterVisitor,
	#traits : 'CSNTWithPrefix',
	#classTraits : 'CSNTWithPrefix classTrait',
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #'instance creation' }
CSNModelImporterGWTUIBinderVisitor >> createAttribute: aAttributeClass for: attributeElement [
	^ (self create: aAttributeClass)
		name: attributeElement name;
		attributeValue: attributeElement value asLowercase;
		widget: entity;
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

{ #category : #visitor }
CSNModelImporterGWTUIBinderVisitor >> visitCSNAttribute: anElement [
	"I handle all the non standart attribute ..."
	^ (source name = (self prefix, 'field')) ifTrue: [ self visitField: anElement ] ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGWTUIBinderVisitor >> visitField: anElement [
	"create the link witht the attribute in the class
	must return nil because we do not really want to create an attribute"
	^ entity affectedActions: (self factory importer xmlImporter correspondingClass attributes detect: [:attribute | attribute name = source value] ifNone: [ nil ] )
]
