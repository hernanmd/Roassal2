Class {
	#name : #RTViewFolderScript,
	#superclass : #RTUsefulScript,
	#category : #'Roassal2-Plugins'
}

{ #category : #accessing }
RTViewFolderScript >> description [
	^ 
'Let you select a directory and see its content. 
A color is given to each file based on its extension.'
]

{ #category : #hooks }
RTViewFolderScript >> execute [
	
	| fr allChildren b lb |
	fr := UIManager default chooseDirectory.
	fr ifNil: [ ^ self ].
	allChildren := fr allChildren.
	allChildren := allChildren copyWithout: fr.

	b := RTMondrian new.

	b shape box
		withTextAbove: #basename.
	b nodes: fr children forEach: [ :fileRef |
		b shape box 
			size: [ :f | (f size + 1) log * 3 ].
		b nodes: fileRef allChildren.
		b geomEdges connectFrom: #parent.
		b layout tree.

	].
	b layout verticalLine.
	b normalizer
		objects: (allChildren reject: #isDirectory);
		distinctColorUsing: #extension.

	b build.
	
	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: 'Visualization of the folder named ', fr basename.
	lb addText: 'Root folder are indicated as large gray boxes.'.
	lb addText: 'Colored boxes are files.'.
	lb addText: 'Each color indicate a file extension'.
	lb build.
	
	b view inspect.
	
]

{ #category : #hooks }
RTViewFolderScript >> label [
	^ 'Visualizing Folder'
]
