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
	self parentWidget
		ifNil: [ widget := self factory createWidgetFor: anElement.
			^ self clone
				parentWidget: widget;
				visitNodeWithElements: anElement ].
	(self parentWidget isContainer
		or: [ self parentWidget isKindOf: CSNLLayout ])
		ifTrue: [ "A leaf cannot add a widget"
			widget := self factory createWidgetFor: anElement withParent: self parentWidget.
			(widget isKindOf: CSNLLayout)
				ifTrue: [ ^ self clone
						parentWidget: widget;
						visitNodeWithElements: anElement ]
				ifFalse: [ self parentWidget addWidget: widget.
					^ self clone
						parentWidget: widget;
						visitNodeWithElements: anElement ] ].
	(self parentWidget isKindOf: CSNLCell)
		ifTrue: [ "A leaf cannot add a widget"
			widget := self factory createWidgetFor: anElement withParent: self parentWidget.
			self parentWidget widget: widget.
			^ self clone
				parentWidget: widget;
				visitNodeWithElements: anElement ].


	"If a leaf have children nodes. They probably are attributes represented by a node
			ex: a tooltip for a button  "
	"self parentWidget addAttribute: (self factory createAttributeFor: widget from: anElement)."
	^ nil
]

{ #category : #accessing }
CSNXMLGWTVisitor >> xmluiFile [
	^ xmluiFile
]

{ #category : #accessing }
CSNXMLGWTVisitor >> xmluiFile: anObject [
	xmluiFile := anObject
]
