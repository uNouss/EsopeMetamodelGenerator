"
# Segment:

Before the first executable instruction of a fortran subprogram, the SEGMENTS that will be used must be declared.

A SEGMENT can contain as many fortran variables as necessary and of all allowed fortran types. The declaration is done as follows:
```fortran77
c        1         2         3         4         5         6         7
c23456789012345678901234567890123456789012345678901234567890123456789012
c     a example of segment definition
      segment myseg
            integer scalar, array(size), matrix(row, col)
            real x, yy(n)
            real*8 Y, YY(3, MM)
            character*nbca icha(8, ik), chai 
      end segment
```

The statement is included between the words `SEGMENT` and `ENDSEGMENT`. Remember that we are in `Fortran77` and that these instructions must be typed after the seventh column.

`MYSEG` is the name of the class of the structure materialized by this segment. A structure belonging to the class `MYSEG` will contain an integer `scalar`, an array of integers `array`, a matrix `row x col` of integer, ... and finally a string of NBCA characters called `CHAI`.

"
Class {
	#name : #FamixEsopeSegment,
	#superclass : #FamixEsopeEntity,
	#traits : 'FamixTType',
	#classTraits : 'FamixTType classTrait',
	#instVars : [
		'#attributes => FMMany type: #FamixEsopeAttribute opposite: #segment',
		'#pointers => FMMany type: #FamixEsopePointer opposite: #segment'
	],
	#category : #'Famix-Esope-Entities-Entities'
}

{ #category : #meta }
FamixEsopeSegment class >> annotation [

	<FMClass: #Segment super: #FamixEsopeEntity>
	<package: #'Famix-Esope-Entities'>
	<generated>
	^self
]

{ #category : #'private - utility' }
FamixEsopeSegment class >> getNameFrom: anEntity [

	^ (((anEntity removePrefix: #eso) trim removePrefix: #segment)
		  trim removePrefix: ',') trim
]

{ #category : #'private - utility' }
FamixEsopeSegment class >> newEntity: anEntity [

	| aSegment |

	aSegment := self new
		            comment: anEntity;
		            mooseModel: anEntity mooseModel;
		            name: (self getNameFrom: anEntity content lines first);
		            yourself.

	aSegment addAttributes: anEntity.
	^ aSegment
]

{ #category : #meta }
FamixEsopeSegment class >> newFromFortranComment: aFortranComment [

	^ (super newFromFortranComment: aFortranComment)
		  name: (self getNameFrom: aFortranComment content without: #segment);
		  yourself
]

{ #category : #adding }
FamixEsopeSegment >> addAttribute: anObject [
	<generated>
	^ self attributes add: anObject
]

{ #category : #meta }
FamixEsopeSegment >> addAttributes: anEntity [

	| content |
	content := anEntity content lines.

	(content sliceFrom: 2 to: content size - 1) do: [ :a | 
		self
			addAttribute:
				(FamixEsopeAttribute new mooseModel: anEntity mooseModel; name: (' ' split: a) last);
			yourself ]
]

{ #category : #adding }
FamixEsopeSegment >> addPointer: anObject [
	<generated>
	^ self pointers add: anObject
]

{ #category : #accessing }
FamixEsopeSegment >> attributes [
	"Relation named: #attributes type: #FamixEsopeAttribute opposite: #segment"

	<generated>
	<derived>
	^ attributes
]

{ #category : #accessing }
FamixEsopeSegment >> attributes: anObject [

	<generated>
	attributes value: anObject
]

{ #category : #navigation }
FamixEsopeSegment >> attributesGroup [
	<generated>
	<navigation: 'Attributes'>
	^ MooseSpecializedGroup withAll: self attributes asSet
]

{ #category : #accessing }
FamixEsopeSegment >> comment [
	"Relation named: #comment type: #FamixFortranComment opposite: #segment"

	<generated>
	<derived>
	<FMProperty: #comment type: #FamixFortranComment opposite: #segment>
	^ self attributeAt: #comment ifAbsent: [ nil ]
]

{ #category : #accessing }
FamixEsopeSegment >> comment: anObject [

	<generated>
	(self attributeAt: #comment ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self comment.
		self attributeAt: #comment put: anObject.
		otherSide segment: nil ]
	ifNotNil: [ 
		self attributeAt: #comment put: anObject.
		anObject segment: self ]
]

{ #category : #accessing }
FamixEsopeSegment >> pointers [
	"Relation named: #pointers type: #FamixEsopePointer opposite: #segment"

	<generated>
	<derived>
	^ pointers
]

{ #category : #accessing }
FamixEsopeSegment >> pointers: anObject [

	<generated>
	pointers value: anObject
]
