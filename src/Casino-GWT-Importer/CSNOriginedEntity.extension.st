Extension { #name : #CSNOriginedEntity }

{ #category : #'*Casino-GWT-Importer' }
CSNOriginedEntity >> isDummy [
	"this entity can be ignore by the importer
	and must be ignore by the exporter"
	^ false
]
