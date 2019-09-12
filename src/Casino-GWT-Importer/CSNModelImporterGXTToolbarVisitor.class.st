Class {
	#name : #CSNModelImporterGXTToolbarVisitor,
	#superclass : #CSNModelImporterAbstractGWTVisitor,
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #initialization }
CSNModelImporterGXTToolbarVisitor >> initialize [
	super initialize.
	prefix := 'toolbar:'.
]

{ #category : #visitor }
CSNModelImporterGXTToolbarVisitor >> visit: anElement [
	^ anElement accept: self
]

{ #category : #visitor }
CSNModelImporterGXTToolbarVisitor >> visitCSNUIInput: aCSNUIInput [
	^ source name = (self prefix , 'LabelToolItem') ifTrue: [ self createWidget: CSNUIWidgetLabel for: source ] ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTToolbarVisitor >> visitCSNUILabel: aCSNUILabel [
	^ (source name = 'label') ifTrue: [ self createAttribute: aCSNUILabel for: source ] ifFalse: [ nil ]
]
