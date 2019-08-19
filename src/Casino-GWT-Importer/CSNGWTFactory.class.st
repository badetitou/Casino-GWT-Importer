Class {
	#name : #CSNGWTFactory,
	#superclass : #CSNWidgetFactory,
	#category : #'Casino-GWT-Importer'
}

{ #category : #'as yet unclassified' }
CSNGWTFactory >> createAttributesFor: widget from: anElement [
	anElement attributeNodesDo: [ :attribute | self createAttributeFor: widget from: attribute ]
]

{ #category : #'as yet unclassified' }
CSNGWTFactory >> createPage: thePageSource [
	(self create: CSNPage) source: thePageSource; name: thePageSource name 
]

{ #category : #'as yet unclassified' }
CSNGWTFactory >> createWidgetFor: theWidgetSource [
	^ self createWidgetFor: theWidgetSource withParent: nil 
]
