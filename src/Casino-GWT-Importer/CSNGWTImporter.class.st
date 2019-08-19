"
CSNGWTImporter new sourceModel: sourceModel; createModelIn: htmltModel
"
Class {
	#name : #CSNGWTImporter,
	#superclass : #CSNWebModel,
	#instVars : [
		'xmlImporter'
	],
	#category : #'Casino-GWT-Importer'
}

{ #category : #api }
CSNGWTImporter >> addLinkBetweenWidgets [
	(self model allWithSubTypesOf: CSNWidget) select: [ :widget | widget parents isEmpty ] thenDo: [ :widget | self linkWidget: widget ]
]

{ #category : #api }
CSNGWTImporter >> addWidgetAttributes [
]

{ #category : #api }
CSNGWTImporter >> addWidgetDefaultAttributes [

]

{ #category : #'private - generateWidget' }
CSNGWTImporter >> computeWidgetCreation [
	^ (self widgetAnonymousSubclasses, self widgetConstructorsInvocation)
]

{ #category : #initialization }
CSNGWTImporter >> createFactory [
	factory := self factoryClass new
		model: model;
		importer: self;
		addVisitorImporter: CSNModelImporterHTMLVisitor new;
		addVisitorImporter: CSNModelImporterGWTClientVisitor new;
		addVisitorImporter: CSNModelImporterGWTUIBinderVisitor new;
		addVisitorImporter: CSNModelImporterGXTButtonVisitor new;
		addVisitorImporter: CSNModelImporterGXTClientVisitor new;
		addVisitorImporter: CSNModelImporterGXTContainerVisitor new;
		addVisitorImporter: CSNModelImporterGXTFormVisitor new;
		addVisitorImporter: CSNModelImporterGXTGridVisitor new;
		yourself
]

{ #category : #initialization }
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
	"2 steps
1. create the UiBinder widgets -> classes that extend UiBinder
2. Determine the other widgets"

	"STEP 1"

	self sourceModel allModelClasses 
		select: [ :class | class superclassHierarchy anySatisfy: [ :superclass | superclass name = 'UiBinder' ] ] 
		thenDo: [ :classWithXmlUI | self generateXMLUiForXLMUiBinder: (classWithXmlUI typeContainer)].

	"STEP 2"
	self computeWidgetCreation
		do: [ :invocation | 
			| widget |
			widget := self factory createWidgetFor: invocation.
			widget affectedActions: invocation affectation.
			(widget affectedActions isNotNil and: [ widget affectedActions isInvocation not ]) ifTrue: [ widget name: widget affectedActions name ] ]
		displayingProgress: [ :invoc | 'Generate widget : ' , invoc asString ]
		every: 100
]

{ #category : #'private - generateWidget' }
CSNGWTImporter >> generateXMLUiForXLMUiBinder: classWithXmlUI [
	| xmlModel |
	xmlImporter := CSNXMLGWTVisitor new
		importer: self;
		factory: self factory;
		yourself.
	classWithXmlUI sourceAnchor fileReference parent files
		select: [ :file | file basename = (classWithXmlUI name , '.ui.xml') ]
		thenDo: [ :file | 
			xmlImporter
				correspondingClass: classWithXmlUI;
				xmluiFile: file.
			xmlModel := (XMLDOMParser on: file readStream)
				isValidating: false;
				parseDocument.
			xmlModel acceptNodeVisitor: xmlImporter ]
]

{ #category : #api }
CSNGWTImporter >> import [
	#(#generatePage #generateWidgets #addLinkBetweenWidgets #addWidgetAttributes #addWidgetDefaultAttributes)
		do: [ :aStep | self perform: aStep ]
		displayingProgress: [ :aStep | aStep asString ]
		every: 10000
]

{ #category : #'private - linkWidget' }
CSNGWTImporter >> linkWidget: aWidget [
	"Link a widget with its parent if possible.
In java, the widget must exist in a structural entity"

	"1. Check the widget has an affected actions (so it has a variable in java)"

	aWidget affectedActions ifNil: [ ^ nil ].
	"Check if I am a parameter of the add() method. If yes, my parent is the widget that call me"
	(aWidget affectedActions fastAccesses
		collect: #parentNode
		thenSelect:
			[ :parentNode | (parentNode isKindOf: FASTJavaMethodInvocation) and: [ parentNode name = 'add' and: [ parentNode receiver isNotNil and: [ (parentNode receiver isKindOf: FASTJavaMethodInvocation) not ] ] ] ])
		do: [ :parentNodeMethodInvocation | (self widgetsWithAffectedAction: parentNodeMethodInvocation receiver famixVariable) do: [ :parent | parent addWidget: aWidget ] ]
]

{ #category : #'private - generateWidget' }
CSNGWTImporter >> modelWidget [
	^ self sourceModel allClasses select: [ :e | e superclassHierarchy anySatisfy: [ :a | a name = 'Widget' ] ]
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

{ #category : #'private - linkWidget' }
CSNGWTImporter >> widgetsWithAffectedAction: affectedAction [
	 ^ (self model allWithSubTypesOf: CSNWidget) select: [ :widget | widget affectedActions = affectedAction ].
]

{ #category : #accessing }
CSNGWTImporter >> xmlImporter [
	^ xmlImporter
]

{ #category : #accessing }
CSNGWTImporter >> xmlImporter: anObject [
	xmlImporter := anObject
]
