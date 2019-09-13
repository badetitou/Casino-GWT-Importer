Class {
	#name : #CSNModelImporterGXTClientVisitor,
	#superclass : #CSNModelImporterAbstractGWTVisitor,
	#category : #'Casino-GWT-Importer-Importers'
}

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
	^ (({(self prefix , 'Window') . (self prefix , 'FramedPanel')} includes: source name) or: [ (self prefix , 'ContentPanel') = source name and: [ (source attributeAt: 'headingText') isNotEmpty ] ])
		ifTrue: [ self createWidget: aCSNUIFieldset for: source ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTClientVisitor >> visitCSNUIModal: aCSNUIModal [
	^ source name = 'modal' ifTrue: [ self createAttribute: aCSNUIModal for: source ] ifFalse: [ ^ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTClientVisitor >> visitCSNUIPanel: aCSNUIPanel [
	^ (self prefix , 'ContentPanel') = source name ifTrue: [ self createWidget: aCSNUIPanel for: source ] ifFalse: [ nil ]
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
CSNModelImporterGXTClientVisitor >> visitCSNUITab: aCSNUITab [
	^ ({(self prefix , 'PlainTabPanel') . (self prefix , 'TabPanel')} includes: source name) ifTrue: [ self createWidget: aCSNUITab for: source ] ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTClientVisitor >> visitCSNUITitle: aCSNUITitle [
	^ (source name = 'headingText') ifTrue: [ self createAttribute: CSNUITitle for: source ] ifFalse: [ nil ]
]
