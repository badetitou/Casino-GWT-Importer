Class {
	#name : #CSNModelImporterGXTClientVisitor,
	#superclass : #CSNModelImporterVisitor,
	#traits : 'CSNTWithPrefix',
	#classTraits : 'CSNTWithPrefix classTrait',
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #visitor }
CSNModelImporterGXTClientVisitor >> createAttribute: aAttributeClass for: attributeElement [
	^ (self create: aAttributeClass)
		name: attributeElement name;
		attributeValue: attributeElement value asLowercase;
		widget: entity;
		yourself
]

{ #category : #visitor }
CSNModelImporterGXTClientVisitor >> createWidget: aWidgetClass for: widgetElement [
	^ (self create: aWidgetClass)
		source: widgetElement;
		name: widgetElement name;
		yourself
]

{ #category : #initialization }
CSNModelImporterGXTClientVisitor >> initialize [
	super initialize.
	prefix := 'gxt:'.
]

{ #category : #visitor }
CSNModelImporterGXTClientVisitor >> visit: anElement [
	^ anElement accept: self
]

{ #category : #visitor }
CSNModelImporterGXTClientVisitor >> visitCSNUIFieldset: aCSNUIFieldset [
	^ ({(self prefix , 'Window'). (self prefix , 'FramedPanel')} includes: source name)  
		ifTrue: [ self createWidget: aCSNUIFieldset for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTClientVisitor >> visitCSNUISize: aCSNUISize [
	"handle the pixelSize (with height and width)"

	^ source name = 'pixelSize'
		ifTrue: [ | sizeString |
			sizeString := (source value asLowercase substrings: ',') collect: #trimBoth.
			(sizeString first beginsWith: '-')
				ifFalse: [ (self create: CSNUIWidth)
						name: 'width';
						attributeValue: sizeString first , 'px';
						widget: entity ].
			(sizeString second beginsWith: '-')
				ifFalse: [ (self create: CSNUIHeight)
						name: 'height';
						attributeValue: sizeString second , 'px';
						widget: entity ] ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTClientVisitor >> visitCSNUITitle: aCSNUITitle [
	^ (source name = 'headingText') ifTrue: [ self createAttribute: CSNUITitle for: source ] ifFalse: [ nil ]
]
