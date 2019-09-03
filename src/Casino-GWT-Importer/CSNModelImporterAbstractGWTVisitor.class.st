Class {
	#name : #CSNModelImporterAbstractGWTVisitor,
	#superclass : #CSNModelImporterVisitor,
	#traits : 'CSNTWithPrefix',
	#classTraits : 'CSNTWithPrefix classTrait',
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #private }
CSNModelImporterAbstractGWTVisitor >> computeJavaSourcesOf: createdEntity fromAttributeNamed: attributeName [
	"create the link witht the attribute in the class
	must return nil because we do not really want to create an attribute
	
1. get the class where the element should be
2. check if it corresponds to a real attribute
3. check if there are @UiHandler('name of the element') for this element and add them as sources"

	| javaAttribute correspondingClass |
	"1. get the class"
	correspondingClass := self factory importer xmlImporter correspondingClass.
	"2. check attributes"
	javaAttribute := correspondingClass attributes detect: [ :attribute | attribute name = attributeName ] ifOne: [ :attribute | createdEntity addSource: attribute ] ifNone: [ nil ].
	"3. Check the UiHandler"
	(correspondingClass allToScope: FamixTAnnotationInstance)
		select: [ :annotationInstance | annotationInstance annotationType name = 'UiHandler' and: [ annotationInstance attributes anyOne value = attributeName ] ]
		thenDo: [ :handler | createdEntity addSource: handler ].
	^ createdEntity affectedActions: javaAttribute
]

{ #category : #'instance creation' }
CSNModelImporterAbstractGWTVisitor >> createAttribute: aAttributeClass for: attributeElement [
	^ (self create: aAttributeClass)
		name: attributeElement name;
		attributeValue: attributeElement value asLowercase;
		widget: entity;
		yourself
]

{ #category : #visitor }
CSNModelImporterAbstractGWTVisitor >> createWidget: aWidgetClass for: widgetElement [
	| widget | 
	widget :=  (self create: aWidgetClass)
		source: widgetElement;
		name: widgetElement name;
		yourself.
	"In case of a GWT element, check if the element also has java sources"
	(source attributeAt: 'ui:field') ifNotEmpty: [ :attributeName | self computeJavaSourcesOf: widget fromAttributeNamed: attributeName ].
	^ widget
]
