Class {
	#name : #CSNModelImporterGXTButtonVisitor,
	#superclass : #CSNModelImporterAbstractGWTVisitor,
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #initialization }
CSNModelImporterGXTButtonVisitor >> initialize [
	super initialize.
	prefix := 'button:'.
]

{ #category : #visitor }
CSNModelImporterGXTButtonVisitor >> visit: anElement [
	^ anElement accept: self
]

{ #category : #visitor }
CSNModelImporterGXTButtonVisitor >> visitCSNUIButton: aCSNUIButton [
	^ source name = (self prefix , 'TextButton')
		ifTrue: [ | widget |
			source hasElements
				ifTrue: [ widget := (self createWidget: CSNUIDropdownButton for: source)
						addSource: source firstElement;
						yourself ]
				ifFalse: [ widget := self createWidget: aCSNUIButton for: source ].
			widget ]
		ifFalse: [ ^ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTButtonVisitor >> visitCSNUIDisabled: aCSNUIDisabled [
	^ source name = 'enabled'
		ifTrue: [ | disable |
			disable := self createAttribute: aCSNUIDisabled for: source.
			source value = 'false' ifTrue: [ disable disabled: true ] ifFalse: [ disable disabled: false ].
			disable ]
		ifFalse: [ ^ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTButtonVisitor >> visitCSNUIDropdownButton: aCSNUIDropdownButton [
	"already done in TextButton
	only ignore this step with a dummy container"
	^ source name = (self prefix , 'menu') ifTrue: [ CSNDummyContainer new"self createWidget: aCSNUIDropdownButton for: source" ] ifFalse: [ ^ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTButtonVisitor >> visitCSNUILabel: aCSNUILabel [
	^ (source name = 'text') ifTrue: [ self createAttribute: aCSNUILabel for: source ] ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTButtonVisitor >> visitCSNUIPlaceholder: aCSNUIPlaceholder [
	^ source name = 'emptyText' ifTrue: [ self createAttribute: aCSNUIPlaceholder for: source ] ifFalse: [ ^ nil ]
]
