Class {
	#name : #CSNGWTFactory,
	#superclass : #CSNWidgetFactory,
	#category : #'Casino-GWT-Importer'
}

{ #category : #'as yet unclassified' }
CSNGWTFactory >> createPage: thePageSource [
	(self create: CSNPage) source: thePageSource
]
