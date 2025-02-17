Class {
	#name : #RTRadialTreeLayoutTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Tests'
}

{ #category : #tests }
RTRadialTreeLayoutTest >> testEmptyLayout [

	RTRadialTreeLayout on: #()
]

{ #category : #tests }
RTRadialTreeLayoutTest >> testOnGraph [
	"Should not raise an exception"
	| b edges |
	b := RTMondrian new.
	b nodes: (0 to: 20).
	edges := b geomEdges
	    moveBehind;
	    connectFromAll: [ :v | Array with: v // 2 with: v // 3 ].
	b layout radialTree.
	"b layout force."
	b build
]
