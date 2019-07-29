"
CSNGWTImporter new sourceModel: sourceModel; createModelIn: htmltModel
"
Class {
	#name : #CSNGWTImporter,
	#superclass : #CSNWebModel,
	#category : #'Casino-Model-Importer-GWT'
}

{ #category : #api }
CSNGWTImporter >> addLinkBetweenWidgets [
]

{ #category : #api }
CSNGWTImporter >> addWidgetAttributes [
]

{ #category : #api }
CSNGWTImporter >> addWidgetDefaultAttributes [

]

{ #category : #api }
CSNGWTImporter >> factoryClass [
	^ CSNGWTFactory
]

{ #category : #api }
CSNGWTImporter >> generatePage [
	self sourceModel allModelClasses
		select: [ :class | class superclassHierarchyGroup anySatisfy: [ :superClass | superClass name = 'EntryPoint' ] ]
		thenDo: [ :phaseClass | self factory createPage: phaseClass ]
]

{ #category : #api }
CSNGWTImporter >> generateWidgets [
	self model allCSNPage do: [ :page | self generateWidgetOfPage: page ]
]

{ #category : #api }
CSNGWTImporter >> import [
	#(#generatePage #generateWidgets #addLinkBetweenWidgets #addWidgetAttributes #addWidgetDefaultAttributes)
		do: [ :aStep | self perform: aStep ]
		displayingProgress: [ :aStep | aStep asString ]
		every: 10000
]
