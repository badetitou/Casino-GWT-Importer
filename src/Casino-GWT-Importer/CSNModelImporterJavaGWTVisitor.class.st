Class {
	#name : #CSNModelImporterJavaGWTVisitor,
	#superclass : #CSNModelImporterVisitor,
	#category : #'Casino-GWT-Importer'
}

{ #category : #'instance creation' }
CSNModelImporterJavaGWTVisitor >> createAttribute: aWidgetClass for: attributeElement [
	^ (self create: aWidgetClass)
		source: source;
		name: attributeElement attributeName;
		attributeValue: (self getAttributeValueFrom: attributeElement);
		widget: entity;
		yourself
]

{ #category : #'instance creation' }
CSNModelImporterJavaGWTVisitor >> getAttributeValueFrom: anInvocation [
	^ anInvocation parameters first
]

{ #category : #visiting }
CSNModelImporterJavaGWTVisitor >> visitCSNUICWOpen: aCSOpen [
	^ (source isInvocation and: [ source attributeName = 'open' ]) ifTrue: [ self createAttribute: aCSOpen for: source ] ifFalse: [ nil ]
]

{ #category : #visiting }
CSNModelImporterJavaGWTVisitor >> visitCSNUIDisabled: aCSNUIDisabled [
	^ (source isInvocation and: [ source attributeName = 'enabled' ]) ifTrue: [ self createAttribute: aCSNUIDisabled for: source ] ifFalse: [ nil ]
]
