Class {
	#name : #CSNModelImporterGXTContainerVisitor,
	#superclass : #CSNModelImporterAbstractGWTVisitor,
	#category : #'Casino-GWT-Importer-Importers'
}

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> createLayout: aLayoutClass for: sourceCode [
	^ (self create: aLayoutClass)
		source: sourceCode;
		name: sourceCode name;
		yourself
]

{ #category : #initialization }
CSNModelImporterGXTContainerVisitor >> initialize [
	super initialize.
	prefix := 'container:'.
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visit: anElement [
	^ anElement accept: self
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visitCSNContainer: aCSNContainer [
	^ (source name beginsWith: self prefix)
		ifTrue: [ (self factory createAlignementFrom: (source name withoutPrefix: self prefix))
				ifNotNil: [ :alignement | 
					| cell |
					cell := self create: CSNLCell.
					cell position: alignement.
					cell ]
				ifNil: [ nil ] ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visitCSNLBorderLayout: aCSNLBorderLayout [
	^ source name = (self prefix , 'BorderLayoutContainer') ifTrue: [ self createLayout: aCSNLBorderLayout for: source ] ifFalse: [ ^ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visitCSNLCenterAlignement: aCenterAlignementClass [
	^ source = 'center' ifTrue: [ self create: aCenterAlignementClass ] ifFalse: [ nil ] 
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visitCSNLEastAlignement: aEastAlignementClass [
	^ source = 'east' ifTrue: [ self create: aEastAlignementClass ] ifFalse: [ nil ] 
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visitCSNLNorthAlignement: aNorthAlignementClass [
	^ source = 'north' ifTrue: [ self create: aNorthAlignementClass ] ifFalse: [ nil ] 
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visitCSNLSouthAlignement: aSouthAlignementClass [
	^ source = 'south' ifTrue: [ self create: aSouthAlignementClass ] ifFalse: [ nil ] 
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visitCSNLVerticalLayout: aCSNLVerticalLayout [
	^ ({(self prefix , 'VerticalLayoutContainer') . (self prefix , 'HBoxLayoutContainer')} includes: source name) ifTrue: [ self createLayout: CSNLVerticalLayout for: source ] ifFalse: [ ^ nil ]
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visitCSNLWestAlignement: aWestAlignementClass [
	^ source = 'west' ifTrue: [ self create: aWestAlignementClass ] ifFalse: [ nil ] 
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visitCSNUIFieldset: aCSNUIFieldset [
	^ nil
]

{ #category : #visitor }
CSNModelImporterGXTContainerVisitor >> visitCSNUIPanel: aCSNUIPanel [
	source name = (self prefix , 'SimpleContainer') ifTrue: [ ^ self createWidget: aCSNUIPanel for: source ].

	^ ((source name beginsWith: self prefix) and: [ source name endsWith: 'Container' ])
		ifTrue: [ (entity isKindOf: CSNLCell)
				ifTrue: [ | container |
					container := self create: CSNContainer.
					container layout: (self factory createLayoutFor: source withParent: entity).
					container ]
				ifFalse: [ entity layout: (self factory createLayoutFor: source withParent: entity).
					entity layout ] ]
		ifFalse: [ nil ]
]
