Class {
	#name : #BaselineOfCasinoGWTImporter,
	#superclass : #BaselineOf,
	#category : #BaselineOfCasinoGWTImporter
}

{ #category : #baselines }
BaselineOfCasinoGWTImporter >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self defineDependencies: spec.
			self definePackages: spec.
			self defineGroups: spec ]
]

{ #category : #baselines }
BaselineOfCasinoGWTImporter >> defineDependencies: spec [
	spec
		baseline: 'Casino'
		with: [ spec
				loads: 'core-extented';
				repository: 'github://badetitou/Casino:master/src' ]
]

{ #category : #baselines }
BaselineOfCasinoGWTImporter >> defineGroups: spec [
	spec group: 'default' with: #('Casino-GWT-Importer')
]

{ #category : #baselines }
BaselineOfCasinoGWTImporter >> definePackages: spec [
	spec
		package: 'BaselineOfCasinoGWTImporter';
		package: 'Casino-GWT-Importer' with: [ spec requires: #('Casino') ]
]
