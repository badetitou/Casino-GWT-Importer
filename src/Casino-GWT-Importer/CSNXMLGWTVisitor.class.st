Class {
	#name : #CSNXMLGWTVisitor,
	#superclass : #CSNXMLHTMLVisitor,
	#category : #'Casino-GWT-Importer'
}

{ #category : #visiting }
CSNXMLGWTVisitor >> visitDocument: aDocument [
	self
		parentWidget:
			((self factory create: CSNUICustomWidget)
				source: aDocument;
				yourself).
	^ (aDocument nodes flatCollect: #nodes) do: [ :aNode | aNode acceptNodeVisitor: self ]
]

{ #category : #visiting }
CSNXMLGWTVisitor >> visitElement: anElement [
	| widget |

	self parentWidget ifNil: [ 
			widget := self factory createWidgetFor: anElement.
			self factory createAttributesFor: widget from: anElement.
			^ self clone
				parentWidget: widget;
				visitNodeWithElements: anElement ].
	self parentWidget isContainer
		ifTrue: [ "A leaf cannot add a widget"
			widget := self factory createWidgetFor: anElement.
			self parentWidget addWidget: widget.
			self factory createAttributesFor: widget from: anElement.
			^ self clone
				parentWidget: widget;
				visitNodeWithElements: anElement ]
		ifFalse: [ "If a leaf have children nodes. They probably are attributes represented by a node
			ex: a tooltip for a button  "
			self parentWidget addAttribute: (self factory createAttributeFor: widget from: anElement).
			^ nil ]
]