"
https://docs.sencha.com/gxt/3.x/javadoc/com/sencha/gxt/widget/core/client/form/package-summary.html
"
Class {
	#name : #CSNModelImporterGXTFormVisitor,
	#superclass : #CSNModelImporterAbstractGWTVisitor,
	#category : #'Casino-GWT-Importer-Importers'
}

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
	^ source name = (self prefix , 'FieldLabel') ifTrue: [ 
		| label container |
		container := self create: CSNContainer. 
		label := self createWidget: CSNUIWidgetLabel for: source.
		container addWidget: label.
		container 
		 ] ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIInputCheckbox: aCSNUIInputCheckbox [
	^ source name = (self prefix , 'CheckBox')
		ifTrue: [ self createWidget: aCSNUIInputCheckbox for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIInputDate: aCSNUIInputDate [
	^ source name = (self prefix , 'DateField')
		ifTrue: [ self createWidget: aCSNUIInputDate for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIInputEmail: aCSNUIInputEmail [
	^ nil
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIInputFile:  aCSNUIInputFile [
	^ source name = (self prefix , 'FileUploadField')
		ifTrue: [ self createWidget: aCSNUIInputFile for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIInputNumber: aCSNUIInputNumber [
	^ source name = (self prefix , 'NumberField')
		ifTrue: [ self createWidget: aCSNUIInputNumber for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIInputPassword: aCSNUIInputPassword [
	^ source name = (self prefix , 'PasswordField')
		ifTrue: [ self createWidget: aCSNUIInputPassword for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIInputRadio: aCSNUIInputRadio [
	^ source name = (self prefix , 'Radio')
		ifTrue: [ self createWidget: aCSNUIInputRadio for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIInputSearch:  aCSNUIInputSearch [
	^ source name = (self prefix , 'StoreFilterField')
		ifTrue: [ self createWidget: aCSNUIInputSearch for: source ]
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
CSNModelImporterGXTFormVisitor >> visitCSNUILabel: aCSNUILabel [
	^ (source name = 'boxLabel') ifTrue: [ self createAttribute: aCSNUILabel for: source ] ifFalse: [ nil ]
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

{ #category : #visitor }
CSNModelImporterGXTFormVisitor >> visitCSNUIWidth: aCSNUIWidth [
	^ (source name = 'labelWidth') ifTrue: [ | width |
		width := self createAttribute: CSNUIWidth for: source.
		width attributeValue: width attributeValue, 'px'.
		width ] ifFalse: [ nil ]
]
