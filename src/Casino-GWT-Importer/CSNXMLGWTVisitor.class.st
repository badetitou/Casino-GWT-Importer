Class {
	#name : #CSNXMLGWTVisitor,
	#superclass : #CSNXMLHTMLVisitor,
	#instVars : [
		'xmluiFile',
		'correspondingClass'
	],
	#category : #'Casino-GWT-Importer'
}

{ #category : #accessing }
CSNXMLGWTVisitor >> correspondingClass [
	^ correspondingClass
]

{ #category : #accessing }
CSNXMLGWTVisitor >> correspondingClass: anObject [
	correspondingClass := anObject
]

{ #category : #visiting }
CSNXMLGWTVisitor >> visitDocument: aDocument [
	self
		parentWidget:
			((self factory create: CSNUICustomWidget)
				source: aDocument;
				addSource: correspondingClass;
				name: correspondingClass name;
				yourself).
	^ (aDocument nodes flatCollect: #nodes) do: [ :aNode | aNode acceptNodeVisitor: self ]
]

{ #category : #visiting }
CSNXMLGWTVisitor >> visitElement: anElement [
	| widget |
	self parentWidget ifNil: [ widget := self factory createWidgetFor: anElement ] ifNotNil: [ widget := self factory createWidgetFor: anElement withParent: self parentWidget ].
	self parentWidget isContainer ifTrue: [ (widget isKindOf: CSNLLayout) ifFalse: [ "ifTrue, already done by construction" self parentWidget addWidgets: widget ] ].
	(self parentWidget isKindOf: CSNLLayout) ifTrue: [ self parentWidget addWidget: widget ].
	(self parentWidget isKindOf: CSNLCell) ifTrue: [ self parentWidget widget: widget ].

	"If I get a container with a layout, the parent for the futur will be the layout itself"
	(widget isContainer and: [ widget layout isNotNil ]) ifTrue: [ widget := widget layout ].
	^ self clone
		parentWidget: widget;
		visitNodeWithElements: anElement
]

{ #category : #accessing }
CSNXMLGWTVisitor >> xmluiFile [
	^ xmluiFile
]

{ #category : #accessing }
CSNXMLGWTVisitor >> xmluiFile: anObject [
	xmluiFile := anObject
]
