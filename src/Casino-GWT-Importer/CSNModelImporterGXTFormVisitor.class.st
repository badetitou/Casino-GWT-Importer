"
https://docs.sencha.com/gxt/3.x/javadoc/com/sencha/gxt/widget/core/client/form/package-summary.html
"
Class {
	#name : #CSNModelImporterGXTFormVisitor,
	#superclass : #CSNModelImporterVisitor,
	#traits : 'CSNTWithPrefix',
	#classTraits : 'CSNTWithPrefix classTrait',
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #'instance creation' }
CSNModelImporterGXTFormVisitor >> createAttribute: aAttributeClass for: attributeElement [
	^ (self create: aAttributeClass)
		name: attributeElement name;
		attributeValue: attributeElement value asLowercase;
		widget: entity;
		yourself
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> createWidget: aWidgetClass for: widgetElement [
	^ (self create: aWidgetClass)
		source: widgetElement;
		name: widgetElement name;
		yourself
]

{ #category : #initialization }
CSNModelImporterGXTFormVisitor >> initialize [
	super initialize.
	prefix := 'form:'.
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visit: anElement [
	^ anElement accept: self
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIFieldset: aCSNUIFieldset [
	^ source name = (self prefix , 'FieldSet')
		ifTrue: [ self createWidget: aCSNUIFieldset for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIInput: aCSNUIInput [
	^ source name = (self prefix , 'FieldLabel') ifTrue: [ self createWidget: CSNUIWidgetLabel for: source ] ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIInputCheckbox: aCSNUIInputCheckbox [
	^ source name = (self prefix , 'CheckBox')
		ifTrue: [ self createWidget: aCSNUIInputCheckbox for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIInputNumber: aCSNUIInputNumber [
	^ source name = (self prefix , 'NumberField')
		ifTrue: [ self createWidget: aCSNUIInputNumber for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIInputPassword: aCSNInputPassword [
	^ source name = (self prefix , 'PasswordField')
		ifTrue: [ self createWidget: aCSNInputPassword for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIInputRadio: aCSNUIInputRadio [
	^ source name = (self prefix , 'Radio')
		ifTrue: [ self createWidget: aCSNUIInputRadio for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIInputText: aCSNUIInputText [
	^ source name = (self prefix , 'TextField')
		ifTrue: [ self createWidget: aCSNUIInputText for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIInputTime:  aCSNUIInputTime [
	^ source name = (self prefix , 'TimeField')
		ifTrue: [ self createWidget: aCSNUIInputTime for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUISelect: aCSNUISelect [
	^ source name = (self prefix , 'ComboBox')
		ifTrue: [ self createWidget: aCSNUISelect for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUITextarea: aCSNUITextarea [
	^ source name = (self prefix , 'TextArea')
		ifTrue: [ self createWidget: aCSNUITextarea for: source ]
		ifFalse: [ nil ]
]
