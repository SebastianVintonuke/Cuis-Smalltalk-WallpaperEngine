'From Cuis6.2 [latest update: #6156] on 26 May 2024 at 11:13:38 pm'!
'Description '!
!provides: 'WallpaperEngine' 1 2!
SystemOrganization addCategory: #'WallpaperEngine-UI'!
SystemOrganization addCategory: #'WallpaperEngine-Model'!


!classDefinition: #WallpaperEngineWindow category: #'WallpaperEngine-UI'!
SystemWindow subclass: #WallpaperEngineWindow
	instanceVariableNames: 'wallpaperList previewImageMorph applyButtonMorph addButtonMorph removeButtonMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'WallpaperEngine-UI'!
!classDefinition: 'WallpaperEngineWindow class' category: #'WallpaperEngine-UI'!
WallpaperEngineWindow class
	instanceVariableNames: ''!

!classDefinition: #DynamicWallpaperRunnerTest category: #'WallpaperEngine-Model'!
TestCase subclass: #DynamicWallpaperRunnerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'WallpaperEngine-Model'!
!classDefinition: 'DynamicWallpaperRunnerTest class' category: #'WallpaperEngine-Model'!
DynamicWallpaperRunnerTest class
	instanceVariableNames: ''!

!classDefinition: #StaticWallpaperTest category: #'WallpaperEngine-Model'!
TestCase subclass: #StaticWallpaperTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'WallpaperEngine-Model'!
!classDefinition: 'StaticWallpaperTest class' category: #'WallpaperEngine-Model'!
StaticWallpaperTest class
	instanceVariableNames: ''!

!classDefinition: #WallpaperEngineTest category: #'WallpaperEngine-Model'!
TestCase subclass: #WallpaperEngineTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'WallpaperEngine-Model'!
!classDefinition: 'WallpaperEngineTest class' category: #'WallpaperEngine-Model'!
WallpaperEngineTest class
	instanceVariableNames: ''!

!classDefinition: #WallpaperEngineWindowModel category: #'WallpaperEngine-UI'!
Object subclass: #WallpaperEngineWindowModel
	instanceVariableNames: 'index wallpaperEngine'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'WallpaperEngine-UI'!
!classDefinition: 'WallpaperEngineWindowModel class' category: #'WallpaperEngine-UI'!
WallpaperEngineWindowModel class
	instanceVariableNames: ''!

!classDefinition: #DynamicWallpaperRunner category: #'WallpaperEngine-Model'!
Object subclass: #DynamicWallpaperRunner
	instanceVariableNames: 'isRuning runner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'WallpaperEngine-Model'!
!classDefinition: 'DynamicWallpaperRunner class' category: #'WallpaperEngine-Model'!
DynamicWallpaperRunner class
	instanceVariableNames: ''!

!classDefinition: #Wallpaper category: #'WallpaperEngine-Model'!
Object subclass: #Wallpaper
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'WallpaperEngine-Model'!
!classDefinition: 'Wallpaper class' category: #'WallpaperEngine-Model'!
Wallpaper class
	instanceVariableNames: ''!

!classDefinition: #DynamicWallpaper category: #'WallpaperEngine-Model'!
Wallpaper subclass: #DynamicWallpaper
	instanceVariableNames: 'frames'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'WallpaperEngine-Model'!
!classDefinition: 'DynamicWallpaper class' category: #'WallpaperEngine-Model'!
DynamicWallpaper class
	instanceVariableNames: ''!

!classDefinition: #SolidColorWallpaper category: #'WallpaperEngine-Model'!
Wallpaper subclass: #SolidColorWallpaper
	instanceVariableNames: 'color'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'WallpaperEngine-Model'!
!classDefinition: 'SolidColorWallpaper class' category: #'WallpaperEngine-Model'!
SolidColorWallpaper class
	instanceVariableNames: ''!

!classDefinition: #StaticWallpaper category: #'WallpaperEngine-Model'!
Wallpaper subclass: #StaticWallpaper
	instanceVariableNames: 'image'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'WallpaperEngine-Model'!
!classDefinition: 'StaticWallpaper class' category: #'WallpaperEngine-Model'!
StaticWallpaper class
	instanceVariableNames: ''!

!classDefinition: #WallpaperEngine category: #'WallpaperEngine-Model'!
Object subclass: #WallpaperEngine
	instanceVariableNames: 'wallpapers dynamicWallpaperRunner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'WallpaperEngine-Model'!
!classDefinition: 'WallpaperEngine class' category: #'WallpaperEngine-Model'!
WallpaperEngine class
	instanceVariableNames: ''!


!StaticWallpaperTest commentStamp: '<historical>' prior: 0!
TODO: find a better way to test!

!DynamicWallpaperRunner commentStamp: '<historical>' prior: 0!
Dynamic Wallpapers are arrays of images that switch sequentially every certain number of milliseconds determined by the desired framerate.
However, doing this on the main execution thread would block it.
Putting that code in a block closure and forking it would solve the problem.
Nevertheless, I would also like to maintain control over this code that runs indefinitely to be able to stop the current wallpaper and, for example, switch to another one.

This class provides tools that allow me to solve this issue.
A runner is created with a closure to fork and has methods to run it, stop it, and check if it is running.

The workflow would be to create a block closure, run it, and stop it. Due to the specific needs of my problem, "pausing" is not required and is not implemented.!

!Wallpaper commentStamp: '<historical>' prior: 0!
Abstract class, provides an interface required for all wallpapers!

!DynamicWallpaper commentStamp: '<historical>' prior: 0!
A sequence of images.

It is initialized through a directory (a folder) that contains the images.
The order in which they will be displayed is the order they have within the directory.
The supported formats are the same as those for StaticWallpapers.!

!WallpaperEngineWindow methodsFor: 'structure' stamp: 'S.V. 5/25/2024 21:09:17'!
build1stColumn
	| column |

	wallpaperList := PluggableListMorph
		model: self model
		listGetter: #wallpapersNames
		indexGetter: #selectionIndex
		indexSetter: #selectionIndex:.
		
	column := LayoutMorph newColumn.
	column addMorph: wallpaperList proportionalHeight: 1.

	^ column! !

!WallpaperEngineWindow methodsFor: 'structure' stamp: 'S.V. 5/25/2024 21:09:19'!
build2ndColumn
	| column |

	column := LayoutMorph newColumn.
	column addMorph: self build2ndColumn1stRow.
	column addMorph: self build2ndColumn2ndRow.

	^ column! !

!WallpaperEngineWindow methodsFor: 'structure' stamp: 'S.V. 5/25/2024 21:09:22'!
build2ndColumn1stRow
	| row |
	
	previewImageMorph := ImageMorph new.
	previewImageMorph layoutSpec offAxisEdgeWeight: 0.5.
	self updatePreview.
	
	row := LayoutMorph newColumn.
	row axisEdgeWeight: 0.5;
	addMorph: previewImageMorph.

	^ row! !

!WallpaperEngineWindow methodsFor: 'structure' stamp: 'S.V. 5/25/2024 22:57:36'!
build2ndColumn2ndRow
	| row |
	
	addButtonMorph := PluggableButtonMorph
		model: self model
		stateGetter: nil
		action: #addWallpaper
		label: 'Add'
		ballonText: 'Add a wallpaper'.
	addButtonMorph layoutSpec offAxisEdgeWeight: 0.5.

	removeButtonMorph := PluggableButtonMorph
		model: self model
		stateGetter: nil
		action: #removeWallpaper
		label: 'Remove'
		ballonText: 'Remove a wallpaper'.
	removeButtonMorph layoutSpec offAxisEdgeWeight: 0.5.

	applyButtonMorph := PluggableButtonMorph
		model: self model
		stateGetter: nil
		action: #applyWallpaper
		label: 'Apply'
		ballonText: 'Apply a wallpaper'.
	applyButtonMorph layoutSpec offAxisEdgeWeight: 0.5.

	row := LayoutMorph newRow.
	row axisEdgeWeight: 0.5.
	row addMorph: addButtonMorph.
	row addMorph: removeButtonMorph.
	row addMorph: applyButtonMorph.

	^ row
! !

!WallpaperEngineWindow methodsFor: 'structure' stamp: 'S.V. 5/25/2024 21:09:29'!
buildMorphicWindow

	self layoutMorph beRow;
	separation: 10;
	axisEdgeWeight: 0.5;

	addMorph: self build1stColumn
		layoutSpec: (LayoutSpec proportionalWidth: 0.3);
	addMorph: self build2ndColumn
		layoutSpec: (LayoutSpec proportionalWidth: 0.7)! !

!WallpaperEngineWindow methodsFor: 'events' stamp: 'S.V. 5/25/2024 21:09:43'!
suscribeToModelEvents
	^ self model when: #selectionChanged send: #updatePreview to: self! !

!WallpaperEngineWindow methodsFor: 'events' stamp: 'S.V. 5/25/2024 21:09:46'!
updatePreview
	previewImageMorph image: (self model selected preview).
	wallpaperList updateList! !

!WallpaperEngineWindow methodsFor: 'initialization' stamp: 'S.V. 5/25/2024 21:09:35'!
defaultExtent
	^ 600@300
	! !

!WallpaperEngineWindow methodsFor: 'initialization' stamp: 'S.V. 5/25/2024 21:09:37'!
initializeWith: aModelToRefer
	self setLabel: 'Wallpaper Engine'.
	self model: aModelToRefer.
	self buildMorphicWindow.
	self openInWorld.
	self morphExtent: (self defaultExtent).
	self suscribeToModelEvents
	! !

!WallpaperEngineWindow methodsFor: 'initialization' stamp: 'S.V. 5/25/2024 21:09:40'!
windowColor
	^ Theme current defaultWindowColor! !

!WallpaperEngineWindow class methodsFor: 'instance creation' stamp: 'S.V. 5/24/2024 01:19:17'!
open
	^ self openWallpaperEngineViewWithModel: WallpaperEngineWindowModel new.

"
Morphic-Menus / TheWorldMenu class / preferencesMenuOptions

{
	#submenuOf  			-> 		TheWorldMenu preferencesLabel.
	#itemGroup 			-> 		10.
	#itemOrder 			-> 		90.
	#label 			-> 		'Wallpapers...'.
	#object 			-> 		WallpaperEngineWindow.
	#selector 			-> 		#open.
	#icon 			-> 		#worldIcon.
	#balloonText 	-> 		'set a wallpaper.'
} asDictionary.
"! !

!WallpaperEngineWindow class methodsFor: 'instance creation' stamp: 'S.V. 5/23/2024 23:36:37'!
openWallpaperEngineViewWithModel: aWallpaperEngineModelToRefer.
	^ self new initializeWith: aWallpaperEngineModelToRefer! !

!DynamicWallpaperRunnerTest methodsFor: 'testing' stamp: 'S.V. 5/25/2024 23:07:29'!
test01aDynamicWallpaperRunnerStartsStopped
	| aDynamicWallpaperRunner |
	
	aDynamicWallpaperRunner := DynamicWallpaperRunner newForRunner: [].
	
	self deny: aDynamicWallpaperRunner isRunning! !

!DynamicWallpaperRunnerTest methodsFor: 'testing' stamp: 'S.V. 5/25/2024 23:07:48'!
test02aDynamicWallpaperRunnerRunsCodeInBackground
	| aDynamicWallpaperRunner aValueToChangeInRun |
	
	aValueToChangeInRun := 1.
	aDynamicWallpaperRunner := DynamicWallpaperRunner newForRunner: [
		aValueToChangeInRun := aValueToChangeInRun + 1.
		(Delay forMilliseconds: 100) wait.
	].
	
	aDynamicWallpaperRunner run.
	(Delay forMilliseconds: 1000) wait.

	self assert: aDynamicWallpaperRunner isRunning.
	self assert: aValueToChangeInRun > 1.

	aDynamicWallpaperRunner stop
	
	
	! !

!DynamicWallpaperRunnerTest methodsFor: 'testing' stamp: 'S.V. 5/25/2024 23:08:08'!
test03aDynamicWallpaperRunnerStopsCodeRunningInBackground
	| aDynamicWallpaperRunner aValueToChangeInRun finalValue |
	
	aValueToChangeInRun := 1.
	aDynamicWallpaperRunner := DynamicWallpaperRunner newForRunner: [
		aValueToChangeInRun := aValueToChangeInRun + 1.
		(Delay forMilliseconds: 100) wait.
	].
	
	aDynamicWallpaperRunner run.
	(Delay forMilliseconds: 1000) wait.
	aDynamicWallpaperRunner stop.
	finalValue := aValueToChangeInRun.
	(Delay forMilliseconds: 1000) wait.

	self deny: aDynamicWallpaperRunner isRunning.
	self assert: aValueToChangeInRun = finalValue! !

!StaticWallpaperTest methodsFor: 'testing' stamp: 'S.V. 5/25/2024 23:11:05'!
test01aStaticWallpaperKnowsItsName
	| aStaticWallpaper |

	aStaticWallpaper := StaticWallpaper withName: self exampleStaticName fromFile: self exampleStaticFileEntry.
	
	self assert: aStaticWallpaper name equals: self exampleStaticName.! !

!StaticWallpaperTest methodsFor: 'testing' stamp: 'S.V. 5/25/2024 23:11:23'!
test02aStaticWallpaperKnowsItsImage
	| aStaticWallpaper |

	aStaticWallpaper := StaticWallpaper withName: self exampleStaticName fromFile: self exampleStaticFileEntry.

	self assert: aStaticWallpaper image equals: self exampleStaticImage.! !

!StaticWallpaperTest methodsFor: 'testing' stamp: 'S.V. 5/25/2024 23:11:46'!
test03aStaticWallpaperKnowsHowToPreviewItself
	| aStaticWallpaper |

	aStaticWallpaper := StaticWallpaper withName: self exampleStaticName fromFile: self exampleStaticFileEntry.

	self assert: aStaticWallpaper preview equals: self exampleStaticPreview.! !

!StaticWallpaperTest methodsFor: 'setUp' stamp: 'S.V. 5/26/2024 03:27:25'!
exampleStaticFileEntry
	^ 'StaticExample.jpg' asFileEntry! !

!StaticWallpaperTest methodsFor: 'setUp' stamp: 'S.V. 5/24/2024 02:08:48'!
exampleStaticImage
	^ Form fromFileEntry: self exampleStaticFileEntry! !

!StaticWallpaperTest methodsFor: 'setUp' stamp: 'S.V. 5/26/2024 03:27:33'!
exampleStaticName
	^ 'Static Example'! !

!StaticWallpaperTest methodsFor: 'setUp' stamp: 'S.V. 5/24/2024 02:08:57'!
exampleStaticPreview
	^ self exampleStaticImage magnifyTo: 384@216! !

!WallpaperEngineTest methodsFor: 'testing' stamp: 'S.V. 5/26/2024 01:21:10'!
test01aWallpaperEngineStartsEmpty
	| aWallpaperEngine |
	
	aWallpaperEngine := WallpaperEngine new.
	
	self deny: aWallpaperEngine hasWallpapers! !

!WallpaperEngineTest methodsFor: 'testing' stamp: 'S.V. 5/26/2024 01:46:24'!
test02aWallpaperEngineCanAddAWallpaper
	| aWallpaperEngine aStaticWallpaper |
	
	aStaticWallpaper := StaticWallpaper example.
	aWallpaperEngine := WallpaperEngine new.
	
	aWallpaperEngine addWallpaper: aStaticWallpaper.
	
	self assert: aWallpaperEngine hasWallpapers! !

!WallpaperEngineTest methodsFor: 'testing' stamp: 'S.V. 5/26/2024 02:16:15'!
test03aWallpaperEngineCanRemoveAWallpaper
	| aWallpaperEngine aStaticWallpaper |
	
	aStaticWallpaper := StaticWallpaper example.
	aWallpaperEngine := WallpaperEngine new.
	
	aWallpaperEngine addWallpaper: aStaticWallpaper.
	aWallpaperEngine removeWallpaper: aStaticWallpaper.
	
	self deny: aWallpaperEngine hasWallpapers! !

!WallpaperEngineTest methodsFor: 'testing' stamp: 'S.V. 5/26/2024 02:16:54'!
test04aWallpaperEngineRaisesAnErrorWhenRemovingANonExistentWallpaper
	| aWallpaperEngine aStaticWallpaper |
	
	aStaticWallpaper := StaticWallpaper example.
	aWallpaperEngine := WallpaperEngine new.

	self should: [ aWallpaperEngine removeWallpaper: aStaticWallpaper ]
		raise: Error
		description: WallpaperEngine errorWallpaperNotFound! !

!WallpaperEngineTest methodsFor: 'testing' stamp: 'S.V. 5/26/2024 02:17:11'!
test05aWallpaperEngineCanStartWithADefault
	| aWallpaperEngine |
	
	aWallpaperEngine := WallpaperEngine newWithDefault.

	self should: (aWallpaperEngine hasWallpapers: 1)! !

!WallpaperEngineTest methodsFor: 'testing' stamp: 'S.V. 5/26/2024 02:17:29'!
test06aWallpaperEngineCanStartWithSampleWallpapers
	| aWallpaperEngine |
	
	aWallpaperEngine := WallpaperEngine newWithExamples.

	self should: (aWallpaperEngine hasWallpapers: 3)! !

!WallpaperEngineWindowModel methodsFor: 'initialization' stamp: 'S.V. 5/25/2024 21:09:59'!
initialize
	index := 1.
	wallpaperEngine := WallpaperEngine newWithExamples! !

!WallpaperEngineWindowModel methodsFor: 'binding' stamp: 'S.V. 5/25/2024 21:49:23'!
addWallpaper
	self request: 'With Name: '
		initialAnswer: ''
		do: [ :aNameToAssign |
			aNameToAssign isEmpty ifFalse: [
				self request: 'From file/directory/color: '
					initialAnswer: ''
					do: [ :aDirectoryOrAFileOrAColor |
						aDirectoryOrAFileOrAColor isEmpty ifFalse: [
							| newWallpaper |
							newWallpaper := Wallpaper withName: aNameToAssign from: aDirectoryOrAFileOrAColor.
							wallpaperEngine addWallpaper: newWallpaper.
							self selectionIndex: wallpaperEngine wallpapers size
						]
					].
			]
		]! !

!WallpaperEngineWindowModel methodsFor: 'binding' stamp: 'S.V. 5/25/2024 21:09:54'!
applyWallpaper
	wallpaperEngine setWallpaper: self selected! !

!WallpaperEngineWindowModel methodsFor: 'binding' stamp: 'S.V. 5/25/2024 19:08:30'!
removeWallpaper
	(self selected name = SolidColorWallpaper defaultWallpaperName) ifTrue: [ ^ self ].
	wallpaperEngine removeWallpaper: self selected.
	self selectionIndex: self selectionIndex - 1.
	self triggerEvent: #selectionChanged! !

!WallpaperEngineWindowModel methodsFor: 'user interface support' stamp: 'S.V. 5/25/2024 21:09:06'!
selected
	^ wallpaperEngine wallpapers at: index ifAbsent: [
		self error: 'Wallpaper Not Found at Index'
	]! !

!WallpaperEngineWindowModel methodsFor: 'user interface support' stamp: 'S.V. 5/25/2024 21:09:10'!
selectionIndex
	^ index! !

!WallpaperEngineWindowModel methodsFor: 'user interface support' stamp: 'S.V. 5/26/2024 16:57:18'!
selectionIndex: anIndex
	(anIndex = 0) ifTrue: [ ^ self ].
	index := anIndex.
	self triggerEvent: #selectionChanged! !

!WallpaperEngineWindowModel methodsFor: 'user interface support' stamp: 'S.V. 5/25/2024 21:09:13'!
wallpapersNames
	^ wallpaperEngine wallpapersNames! !

!DynamicWallpaperRunner methodsFor: 'initialization' stamp: 'S.V. 5/24/2024 02:36:20'!
initialize
	isRuning := false! !

!DynamicWallpaperRunner methodsFor: 'initialization' stamp: 'S.V. 5/24/2024 02:34:20'!
runner: aClosureToRun
	runner := aClosureToRun! !

!DynamicWallpaperRunner methodsFor: 'public' stamp: 'S.V. 5/25/2024 15:30:24'!
isRunning
	^ isRuning! !

!DynamicWallpaperRunner methodsFor: 'public' stamp: 'S.V. 5/25/2024 17:52:03'!
run
	isRuning := true.
	runner fork! !

!DynamicWallpaperRunner methodsFor: 'public' stamp: 'S.V. 5/25/2024 22:07:56'!
stop
	isRuning := false! !

!DynamicWallpaperRunner class methodsFor: 'instance creation' stamp: 'S.V. 5/25/2024 17:55:47'!
newForRunner: aClosureToBind
	| instance |
	instance := self new.
	instance runner: [ [ instance isRunning ] whileTrue: aClosureToBind ].
	^ instance! !

!Wallpaper methodsFor: 'public' stamp: 'S.V. 5/24/2024 01:23:41'!
name
	^ name! !

!Wallpaper methodsFor: 'public' stamp: 'S.V. 5/24/2024 01:24:04'!
preview
	^ self subclassResponsibility! !

!Wallpaper methodsFor: 'doubleDispatch' stamp: 'S.V. 5/24/2024 01:55:06'!
beSetBy: aWallpaperEngine
	^ self subclassResponsibility! !

!Wallpaper class methodsFor: 'dynamicSwitch' stamp: 'S.V. 5/25/2024 21:49:43'!
canBeInitializedFrom: aDirectoryOrAFileOrAColor
	self subclassResponsibility! !

!Wallpaper class methodsFor: 'dynamicSwitch' stamp: 'S.V. 5/25/2024 21:55:54'!
withName: aNameToIdentify from: aDirectoryOrAFileOrAColor
	| subclass |
	subclass := self subclasses detect: [ :aSubclass |
		aSubclass canBeInitializedFrom: aDirectoryOrAFileOrAColor
	].
	subclass ifNil: [ ^ self error: 'Subclass not found for this' ].
	^ subclass withName: aNameToIdentify from: aDirectoryOrAFileOrAColor! !

!Wallpaper class methodsFor: 'morphic' stamp: 'S.V. 5/25/2024 21:04:59'!
previewExtent
	 ^ 384@216! !

!DynamicWallpaper methodsFor: 'initilization' stamp: 'S.V. 5/25/2024 17:01:21'!
withName: aNameToIdentify withFrames: aFramesToDisplay 
	name := aNameToIdentify.
	frames := aFramesToDisplay! !

!DynamicWallpaper methodsFor: 'doubleDispatch' stamp: 'S.V. 5/24/2024 01:55:53'!
beSetBy: aWallpaperEngine
	aWallpaperEngine setDynamicWallpaper: self! !

!DynamicWallpaper methodsFor: 'public' stamp: 'S.V. 5/24/2024 01:24:36'!
frames
	^ frames.! !

!DynamicWallpaper methodsFor: 'public' stamp: 'S.V. 5/25/2024 21:05:10'!
preview
	^ (frames at: 1) magnifyTo: self class previewExtent! !

!DynamicWallpaper class methodsFor: 'instance creation' stamp: 'S.V. 5/25/2024 21:56:07'!
withName: aNameToIdentify fromDirectory: aDirectoryToSearch
	| frames |
	frames :=  aDirectoryToSearch files collect: [ :anImageFile | Form fromFileEntry: anImageFile ].
	^ self new withName: aNameToIdentify withFrames: frames.! !

!DynamicWallpaper class methodsFor: 'example' stamp: 'S.V. 5/26/2024 03:27:05'!
example
	^ self withName: 'Dynamic Example' fromDirectory: 'DynamicExample' asDirectoryEntry! !

!DynamicWallpaper class methodsFor: 'dynamicSwitch' stamp: 'S.V. 5/25/2024 21:50:17'!
canBeInitializedFrom: aDirectoryOrAFileOrAColor
	| files |
	[	files := aDirectoryOrAFileOrAColor asDirectoryEntry files.
		files isEmpty ifTrue: [ ^ false ].
		files do: [ :fileToTryForm | Form fromFileEntry: fileToTryForm ]
	] on: Error do: [ ^ false ].
	^ true! !

!DynamicWallpaper class methodsFor: 'dynamicSwitch' stamp: 'S.V. 5/25/2024 21:56:02'!
withName: aNameToIdentify from: aDirectoryStringToSearch
	^ self withName: aNameToIdentify fromDirectory: aDirectoryStringToSearch asDirectoryEntry! !

!SolidColorWallpaper methodsFor: 'initialization' stamp: 'S.V. 5/25/2024 17:01:30'!
withName: aNameToIdentify withColor: aColorToDisplay 
	name := aNameToIdentify.
	color := aColorToDisplay! !

!SolidColorWallpaper methodsFor: 'doubleDispatch' stamp: 'S.V. 5/25/2024 17:02:08'!
beSetBy: aWallpaperEngine
	aWallpaperEngine setSolidColorWallpaper: self! !

!SolidColorWallpaper methodsFor: 'public' stamp: 'S.V. 5/25/2024 18:24:37'!
color
	^ color! !

!SolidColorWallpaper methodsFor: 'public' stamp: 'S.V. 5/26/2024 23:13:11'!
preview
	^ (ColorForm extent: self class previewExtent) mapColor: Color transparent to: color! !

!SolidColorWallpaper class methodsFor: 'instance creation' stamp: 'S.V. 5/25/2024 21:55:16'!
withName: aNameToIdentify withColor: aColorToDisplay
	^ self new withName: aNameToIdentify withColor: aColorToDisplay! !

!SolidColorWallpaper class methodsFor: 'default' stamp: 'S.V. 5/25/2024 19:07:36'!
default
	^ self withName: self defaultWallpaperName withColor: Theme current background! !

!SolidColorWallpaper class methodsFor: 'default' stamp: 'S.V. 5/25/2024 19:07:29'!
defaultWallpaperName
	^ 'Default'! !

!SolidColorWallpaper class methodsFor: 'dynamicSwitch' stamp: 'S.V. 5/25/2024 21:53:54'!
canBeInitializedFrom: aDirectoryOrAFileOrAColor
	(Color colorFrom: aDirectoryOrAFileOrAColor) ifNil: [ ^ false ].
	^ true! !

!SolidColorWallpaper class methodsFor: 'dynamicSwitch' stamp: 'S.V. 5/25/2024 21:55:26'!
withName: aNameToIdentify from: aStringColorToDisplay
	^ self withName: aNameToIdentify withColor: (Color colorFrom: aStringColorToDisplay)! !

!StaticWallpaper methodsFor: 'initialization' stamp: 'S.V. 5/25/2024 17:01:25'!
withName: aNameToIdentify withImage: anImageToDisplay
	name := aNameToIdentify.
	image := anImageToDisplay! !

!StaticWallpaper methodsFor: 'public' stamp: 'S.V. 5/23/2024 23:01:23'!
image
	^ image! !

!StaticWallpaper methodsFor: 'public' stamp: 'S.V. 5/25/2024 21:05:19'!
preview
	^ image magnifyTo: self class previewExtent! !

!StaticWallpaper methodsFor: 'doubleDispatch' stamp: 'S.V. 5/24/2024 01:57:12'!
beSetBy: aWallpaperEngine
	aWallpaperEngine setStaticWallpaper: self! !

!StaticWallpaper class methodsFor: 'example' stamp: 'S.V. 5/26/2024 03:27:01'!
example
	^ self withName: 'Static Example' fromFile: 'StaticExample.jpg' asFileEntry! !

!StaticWallpaper class methodsFor: 'instance creation' stamp: 'S.V. 5/25/2024 21:57:38'!
withName: aNameToIdentify fromFile: aFileToSearch
	| image |
	image := Form fromFileEntry: aFileToSearch.
	^ self new withName: aNameToIdentify withImage: image! !

!StaticWallpaper class methodsFor: 'dynamicSwitch' stamp: 'S.V. 5/25/2024 21:56:39'!
canBeInitializedFrom: aDirectoryOrAFileOrAColor
	[ Form fromFileEntry: aDirectoryOrAFileOrAColor asFileEntry ] on: Error do: [ ^ false ].
	^ true! !

!StaticWallpaper class methodsFor: 'dynamicSwitch' stamp: 'S.V. 5/25/2024 21:57:14'!
withName: aNameToIdentify from: aStringFileToSearch
	^ self withName: aNameToIdentify fromFile: aStringFileToSearch asFileEntry! !

!WallpaperEngine methodsFor: 'initialization' stamp: 'S.V. 5/25/2024 17:31:25'!
initialize
	wallpapers := OrderedCollection new.
	dynamicWallpaperRunner := DynamicWallpaperRunner newForRunner: [ :aClosureToBind |
		[ [ aClosureToBind isRunning ] whileTrue: [] ]
	].! !

!WallpaperEngine methodsFor: 'testing' stamp: 'S.V. 5/24/2024 01:03:34'!
hasWallpapers
	^ wallpapers isEmpty not! !

!WallpaperEngine methodsFor: 'testing' stamp: 'S.V. 5/25/2024 21:13:18'!
hasWallpapers: aNumberToTry
	^ wallpapers size = aNumberToTry! !

!WallpaperEngine methodsFor: 'doubleDispatch' stamp: 'S.V. 5/25/2024 21:06:02'!
setDynamicWallpaper: aDynamicWallpaperToSet
	self stopDynamicWallpaper.
	dynamicWallpaperRunner := DynamicWallpaperRunner newForRunner: (self world provideDynamicWallpaperClosureFrom: (aDynamicWallpaperToSet frames) withFrameRate: (self class frameRate)).
	dynamicWallpaperRunner run! !

!WallpaperEngine methodsFor: 'doubleDispatch' stamp: 'S.V. 5/25/2024 19:05:32'!
setSolidColorWallpaper: aSolidColorWallpaperToSet
	self stopDynamicWallpaper.
	self world setBackgroundColorFromColor: aSolidColorWallpaperToSet color
! !

!WallpaperEngine methodsFor: 'doubleDispatch' stamp: 'S.V. 5/25/2024 17:07:43'!
setStaticWallpaper: aStaticWallpaperToSet
	self stopDynamicWallpaper.
	self world setStaticImageFromForm: aStaticWallpaperToSet image! !

!WallpaperEngine methodsFor: 'doubleDispatch' stamp: 'S.V. 5/25/2024 17:07:49'!
setWallpaper: aWallpaperToSet
	aWallpaperToSet beSetBy: self! !

!WallpaperEngine methodsFor: 'wallpapers' stamp: 'S.V. 5/24/2024 01:15:01'!
addWallpaper: aWallpaperToAdd
	wallpapers add: aWallpaperToAdd! !

!WallpaperEngine methodsFor: 'wallpapers' stamp: 'S.V. 5/24/2024 01:15:11'!
removeWallpaper: aWallpaperToRemove
	wallpapers remove: aWallpaperToRemove ifAbsent: [ self error: self class errorWallpaperNotFound ]! !

!WallpaperEngine methodsFor: 'wallpapers' stamp: 'S.V. 5/24/2024 01:02:39'!
wallpapers
	^ wallpapers! !

!WallpaperEngine methodsFor: 'wallpapers' stamp: 'S.V. 5/24/2024 01:02:50'!
wallpapersNames
	^ wallpapers collect: [ :wallpaper | wallpaper name ]! !

!WallpaperEngine methodsFor: 'private' stamp: 'S.V. 5/25/2024 22:09:29'!
stopDynamicWallpaper
	(dynamicWallpaperRunner isRunning) ifTrue: [
		dynamicWallpaperRunner stop. (Delay forMilliseconds: 3000) wait "There is a bug where some frames of the dynamic wallpaper still switch after the dynamic wallpaper has been stopped"
	]! !

!WallpaperEngine methodsFor: 'private' stamp: 'S.V. 5/24/2024 00:48:26'!
world
	^ UISupervisor runningWorld.! !

!WallpaperEngine class methodsFor: 'instance creation' stamp: 'S.V. 5/25/2024 21:16:48'!
newWithDefault
	^ self new addWallpaper: SolidColorWallpaper default! !

!WallpaperEngine class methodsFor: 'instance creation' stamp: 'S.V. 5/25/2024 21:46:48'!
newWithExamples
	^ self newWithDefault
			    addWallpaper: StaticWallpaper example;
			    addWallpaper: DynamicWallpaper example! !

!WallpaperEngine class methodsFor: 'error' stamp: 'S.V. 5/24/2024 01:07:30'!
errorWallpaperNotFound
	^ 'Wallpaper Not Found'! !

!WallpaperEngine class methodsFor: 'configuration' stamp: 'S.V. 5/25/2024 21:06:53'!
frameRate
	^ 2! !

!PasteUpMorph methodsFor: '*WallpaperEngine-Extensions' stamp: 'S.V. 5/26/2024 02:32:03'!
provideDynamicWallpaperClosureFrom: aFrameList withFrameRate: aFrameRate
	| frameList delay |

	frameList := aFrameList collect: [ :frame |
		frame magnifyTo: extent.
		frame orderedDither32To16 asColorFormOfDepth: 8.
	].

	delay := Delay forMilliseconds: 1000 / aFrameRate.

	^ [
		frameList do: [ :frame |
			backgroundImage := nil.
			Smalltalk primitiveGarbageCollect.
			backgroundImage := frame.
			Smalltalk primitiveGarbageCollect.
			backgroundImage bits pin.
			self redrawNeeded.
			delay wait.
		]
	].! !

!PasteUpMorph methodsFor: '*WallpaperEngine-Extensions' stamp: 'S.V. 5/26/2024 02:32:10'!
setBackgroundColorFromColor: aColorToUse
	self color: aColorToUse.
	self redrawNeeded! !

!PasteUpMorph methodsFor: '*WallpaperEngine-Extensions' stamp: 'S.V. 5/26/2024 02:32:16'!
setStaticImageFromForm: anImage
	backgroundImage := nil.
	Smalltalk primitiveGarbageCollect.
	backgroundImage := anImage magnifyTo: extent.
	backgroundImage := backgroundImage orderedDither32To16 asColorFormOfDepth: 8.
	Smalltalk primitiveGarbageCollect.
	backgroundImage bits pin.
	self redrawNeeded.! !
