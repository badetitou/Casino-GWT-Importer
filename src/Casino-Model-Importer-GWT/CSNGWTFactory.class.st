Class {
	#name : #CSNGWTFactory,
	#superclass : #CSNWidgetFactory,
	#category : #'Casino-Model-Importer-GWT'
}

{ #category : #'as yet unclassified' }
CSNGWTFactory >> createPage: thePageSource [
	(self create: CSNPage) source: thePageSource
]
