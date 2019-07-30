"
CSNGWTImporter new sourceModel: sourceModel; createModelIn: htmltModel
"
Class {
	#name : #CSNGWTImporter,
	#superclass : #CSNWebModel,
	#instVars : [
		'modelWidgetCache'
	],
	#category : #'Casino-GWT-Importer'
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

{ #category : #'private - generateWidget' }
CSNGWTImporter >> computeWidgetCreation [
	(self widgetAnonymousSubclasses, self widgetConstructorsInvocation)
		do: [ :invocation | 
			| widget |
			widget := self factory createWidgetFor: invocation.
			widget affectedActions: invocation affectation.
			(widget affectedActions isNotNil and: [ widget affectedActions isInvocation not ]) ifTrue: [ widget name: widget affectedActions name ] ]
		displayingProgress: [ :invoc | 'Generate widget : ' , invoc asString ]
		every: 100
]

{ #category : #api }
CSNGWTImporter >> factoryClass [
	^ CSNGWTFactory
]

{ #category : #api }
CSNGWTImporter >> generatePage [
	self sourceModel allModelClasses asOrderedCollection
		select: [ :class | class superclassHierarchyGroup anySatisfy: [ :superClass | superClass name = 'EntryPoint' ] ]
		thenDo: [ :phaseClass | self factory createPage: phaseClass ]
]

{ #category : #api }
CSNGWTImporter >> generateWidgets [
	| potentialWidgets |
	potentialWidgets := (self computeWidgetCreation).
]

{ #category : #api }
CSNGWTImporter >> import [
	#(#generatePage #generateWidgets #addLinkBetweenWidgets #addWidgetAttributes #addWidgetDefaultAttributes)
		do: [ :aStep | self perform: aStep ]
		displayingProgress: [ :aStep | aStep asString ]
		every: 10000
]

{ #category : #'private - generateWidget' }
CSNGWTImporter >> modelWidget [
	^ modelWidgetCache ifNil: [ modelWidgetCache := self sourceModel allClasses select: [ :e | e superclassHierarchy anySatisfy: [ :a | a name = 'Widget' ] ] ]
]

{ #category : #'private - generateWidget' }
CSNGWTImporter >> widgetAnonymousSubclasses [
	^ ((self modelWidget flatCollect: [ :widget | widget subclassHierarchy ]) select: #isAnonymousClass)
]

{ #category : #'private - generateWidget' }
CSNGWTImporter >> widgetConstructorsInvocation [
	"Get the constructor and try to determine the stub constructor"

	^ (self modelWidget
		collect: [ :widget | 
			widget methods
				select: [ :method | 
					method isConstructor
						or: [ (method name copyReplaceAll: '.' with: '::') asSymbol = method parentType mooseName  ] ]
				thenCollect: #incomingInvocations ]) flattened
]
