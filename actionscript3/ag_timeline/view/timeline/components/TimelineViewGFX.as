
package net.believecollective.ag2010.view.timeline.components {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.events.AGTimelineElementEvent;
	import net.believecollective.ag2010.model.vo.timeline.AGLandscapeVO;
	import net.believecollective.ag2010.model.vo.timeline.AGTimelineVO;
	import net.believecollective.ag2010.model.vo.timeline.eras.AGEraSceneVO;
	import net.believecollective.ag2010.model.vo.timeline.eras.AGEraVO;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;
	import net.believecollective.ag2010.patterns.proxy.ConfigProxy;
	import net.believecollective.ag2010.patterns.proxy.TimelineProxy;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimeLineElementsBase;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimelineEventGraphic;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimelineEventLabel;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimelineLandscapeGraphic;
	import net.believecollective.utils.ArrayUtils;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * LoaderView Component
	 * 
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	 
	public class TimelineViewGFX extends MovieClip {
		
		//consts
		public static const TIMELINE_NAME_NEPAL : String = "Timeline-Nepal";
		public static const TIMELINE_NAME_GURKHAS : String = "Timeline-Gurkhas";
		public static const TIMELINE_NAME_WALES : String = "Timeline-Wales";
		public static const TIMELINE_NAME_UK : String = "Timeline-UK";
		public static const TIMELINE_NAME_WORLD : String = "Timeline-World";		public static const TIMELINE_NAME_GUIDE : String = "Timeline-Guide";
		
		public static const TIMELINE_NAMES : Array = [TIMELINE_NAME_NEPAL,TIMELINE_NAME_GURKHAS,TIMELINE_NAME_WALES,TIMELINE_NAME_UK,TIMELINE_NAME_WORLD,TIMELINE_NAME_GUIDE];

		// DATA OBJECTS
		private var _oProxy : TimelineProxy;
		private var _oConfig : ConfigProxy;		private var _oTimelineVO : AGTimelineVO;	
		private var _oTimelineLandscapeVO : AGLandscapeVO;
		
		// VARS for loading sequence
		private var _bLoading : Boolean;
		private var _bInteruptSequence : Boolean;  // if an event is selcted during landscape load, the sequence will be interupted to load the selected event detail png
		private var _iLabelEraCounter : int;
		private var _oCurrentEraPopulating : AGTimelineEra; // the era (display object) which is currently being loaded into - is always the closest remaining era to the global YEAR_IN_FOCUS 
		private var _bLabelLoadComplete : Boolean; // labels are all loaded before BG loading begins		private var _bSkyLoadComplete : Boolean; // sky is loaded in its entirety before scenery loading begins		private var _bSceneryLoadComplete : Boolean; // scenery (landscape) is loaded in its entirety before silhouette loading begins
		private var _bSilhouetteLoadComplete : Boolean; // ALL sillhouettes are loaded before image-detail loadding begins
		private var _aErasToPopulateSky : Array; // the eras which have sky elements left to load		private var _aErasToPopulateLandscape : Array; // the eras which have landscape elements left to load
		private var _aErasToPopulateEvents : Array; // the eras which have event graphics left to load
		private var _aErasToPopulateDetails : Array; // the eras which have silhouettes details left to load
		
		// Display Object references
		private var _aAllEventGFX: Array; // references silhouette display objects
		private var _aLandscapePNGs: Array; // references any landscape elements which have detail images associated with them (indexed according to event which triggers them)		private var _aLandscapeAnimations: Array; // references any landscape elements which have animations images associated with them (indexed according to event which triggers them)
		private var _aAllLabels: Array; // references label display objects
		private var _aEras : Array; // contains references to each of the AGTimelineEra classes (display objects) in chronolgical order
		private var _aTimelineElements : Array; // an array of arrays (one for each timeline 'sections', and corresponding to TIMELINE_NAMES ) which reference all the timeline elements (labels and graphics) belonging to each timeline section
		private var _mcGradient : AGTimelineGradient;
		
		
		function TimelineViewGFX(arg_oConfig : ConfigProxy, arg_oTLP:TimelineProxy) {
			this.alpha = 0;
			_oProxy = arg_oTLP;
			_oConfig = arg_oConfig;
			// eras
			_aEras = new Array();
//			_oCurrentEra = addChild(new AGTimelineEra()) as AGTimelineEra; // initialises the immediate era
			// timelines
			_aTimelineElements = new Array();
			for (var i:int=0; i< TIMELINE_NAMES.length; i++) {
				_aTimelineElements.push(new Array());
			}
			// elements
			_aAllLabels = new Array();			_aAllEventGFX = new Array();			_aLandscapePNGs = new Array();			_aLandscapeAnimations = new Array();
		}
		
//////// LOADING SEQUENCE

		public function fInitLoadingSequence() : void {
			_oTimelineVO = _oProxy.timeline;		
			fAddEraContainers();
			//
			_aErasToPopulateSky = new Array();			_aErasToPopulateLandscape = new Array();
			_aErasToPopulateEvents = new Array();
			_aErasToPopulateDetails = new Array();
			for (var i:int = 0; i< _aEras.length; i++){					
				_aErasToPopulateSky[i] = _aEras[i];				_aErasToPopulateLandscape[i]=_aEras[i];
				_aErasToPopulateEvents[i]=_aEras[i];
				_aErasToPopulateDetails[i]=_aEras[i];
			}
			// event dispatched everytime a timelineGraphic (label, landscape, silhouette or detail-image) finishes loading
			addEventListener(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED, fLoadNextAsset);
			_iLabelEraCounter = 0;
			fLoadNextLabel();
			
			// gradient overlay added over the top of all eras and posisitioned so that it covers the timeline area - this mc will not move with the timeline 
			_mcGradient = addChild(new AGTimelineGradient) as AGTimelineGradient;
			_mcGradient.mouseEnabled = false;			_mcGradient.mouseChildren = false;
			_mcGradient.fToggle(false);		}

		private function fAddEraContainers() : void {
			for each (var VO : AGEraVO in  _oTimelineVO.eras) {
				var t_oEra : AGTimelineEra = new AGTimelineEra(VO) as AGTimelineEra;
				addChild(t_oEra);
				_aEras.push(t_oEra);
			}
		}

		private function fInitLandscape() : void {
			// set sky and scenery VOs for each ERA 
			for (var i :int = 0; i< _oTimelineLandscapeVO.eras.length; i++) {
				(_aEras[i] as AGTimelineEra).sky = (_oTimelineLandscapeVO.eras[i] as AGEraSceneVO).sky;				(_aEras[i] as AGTimelineEra).scenery = (_oTimelineLandscapeVO.eras[i] as AGEraSceneVO).scenery;
				(_aEras[i] as AGTimelineEra).fTint(_oTimelineLandscapeVO.eras[i]);
			}
			//begin loading current era sky graphics
			_oCurrentEraPopulating = _aEras[ApplicationFacade.CURRENT_ERA_IN_VIEW];
			fLoadNextBGGraphic(_oCurrentEraPopulating);
			_bLoading = true;
		}

		public function fLoadNextAsset(event : Event = null) : void {
			if (!_bLoading) return;
			// called each time a timelineGraphic (landscape, silhouette or detail-image) finishes loading 
			// and loads the next most important graphic
			if (!_bLabelLoadComplete) {
				fLoadNextLabel();
			}
			else if (_bInteruptSequence) {
				_bInteruptSequence = false; // only need to skip once
				return;
			}
			else if (!_bSkyLoadComplete) {
				//load next sky graphic
				if (_oCurrentEraPopulating.sky.length == 0 && _oCurrentEraPopulating.divider.length == 0) _oCurrentEraPopulating = _aEras[fLookupNextClosestEra(_aErasToPopulateSky)];
				if (_oCurrentEraPopulating == null) {
					_bSkyLoadComplete = true;
					_oCurrentEraPopulating = _aEras[ApplicationFacade.CURRENT_ERA_IN_VIEW];
					fLoadNextLandscapeGraphic(_oCurrentEraPopulating);
				}
				else fLoadNextBGGraphic(_oCurrentEraPopulating);
			}
			else if (!_bSceneryLoadComplete) {
				//load next landscape graphic
				if (_oCurrentEraPopulating.scenery.length == 0) _oCurrentEraPopulating = _aEras[fLookupNextClosestEra(_aErasToPopulateLandscape)];
				if (_oCurrentEraPopulating == null) {
					_bSceneryLoadComplete = true;
					_oCurrentEraPopulating = _aEras[ApplicationFacade.CURRENT_ERA_IN_VIEW];
					fLoadNextEventGraphic(_oCurrentEraPopulating);
				}
				else fLoadNextLandscapeGraphic(_oCurrentEraPopulating);
			}
			else if (!_bSilhouetteLoadComplete) {
				//load next event graphic
				if (_oCurrentEraPopulating.events.length == 0) _oCurrentEraPopulating = _aEras[fLookupNextClosestEra(_aErasToPopulateEvents)];
				if (_oCurrentEraPopulating == null) {
					_bSilhouetteLoadComplete = true;
					_oCurrentEraPopulating = _aEras[ApplicationFacade.CURRENT_ERA_IN_VIEW];
					_oConfig.sendNotification(ApplicationFacade.NOTE_TIMELINE_MOVE);
					fLoadNextEventDetailGraphic(_oCurrentEraPopulating);
				}
				else {
					fLoadNextEventGraphic(_oCurrentEraPopulating);
				}
			}
			else {
				// load next event detail graphic
				if (_oCurrentEraPopulating.silhouettes.length == 0) _oCurrentEraPopulating = _aEras[fLookupNextClosestEra(_aErasToPopulateDetails)];
				if (_oCurrentEraPopulating == null) {
					_bLoading = false;
					removeEventListener(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED, fLoadNextAsset);
				}
				else fLoadNextEventDetailGraphic(_oCurrentEraPopulating);
			}
		}
		
		private function fLoadNextLabel() : void {
			var _oEra : AGTimelineEra = _aEras[_iLabelEraCounter];
			// send note update loader
			var t_oLabel : AGTimelineEventLabel = _oEra.fAddNextLabel();
			if (t_oLabel != null){
				(_aTimelineElements[ ArrayUtils.INDEXOF(TIMELINE_NAMES, t_oLabel.timelineSection)] as Array).push(t_oLabel);	
				// reference the label indexed by eventID
				_aAllLabels[t_oLabel.eventID] = t_oLabel;
				fLoadNextAsset();
			}
			else if (_iLabelEraCounter + 1 != _aEras.length) {
				_iLabelEraCounter ++;
				fLoadNextLabel();
			}
			else {
				_bLabelLoadComplete = true;
				_oConfig.sendNotification(ApplicationFacade.NOTE_FINISH_LOADING_SEQUENCE);
				TweenMax.to(this, 1.5, {autoAlpha: 1});
				if (_oTimelineLandscapeVO!= null) fInitLandscape(); // if it is null, the function will be called when the VO is set 
			}
		}
		
		private function fLoadNextBGGraphic(arg_oEra : AGTimelineEra) : void {
			arg_oEra.fAddNextBGGraphic();
		}		
		
		private function fLoadNextLandscapeGraphic(arg_oEra : AGTimelineEra) : void {
			var t_o: Object = (arg_oEra.fAddNextLandscapeGraphic());
			if (t_o != null) {
				if (t_o is AGTimelineLandscapeGraphic){
					if (t_o.eventID != 0) {
						if (_aLandscapePNGs[t_o.eventID]) _aLandscapePNGs[t_o.eventID].push(t_o);
						else _aLandscapePNGs[t_o.eventID] = new Array(t_o);
					}
				}
				else if (t_o is AGEventVO){
					if (t_o.eventID != 0) {
						if (_aLandscapeAnimations[t_o.eventID]) _aLandscapeAnimations[t_o.eventID].push(t_o);
						else _aLandscapeAnimations[t_o.eventID] = new Array(t_o);
					}
				}
			}
		}

		private function fLoadNextEventGraphic(arg_oEra : AGTimelineEra) : void {
			arg_oEra.fAddNextEventGraphic();
		}
		
		private function fLoadNextEventDetailGraphic(arg_oEra : AGTimelineEra) : void {
			arg_oEra.fLoadNextEventDetailGraphic();
		}			

/////////////////////////
/////// PUBLIC FUNCTIONS
		
		public function fShiftEras() : void {
			if (_bLoading) _oCurrentEraPopulating = _aEras[ApplicationFacade.CURRENT_ERA_IN_VIEW]; // reset loading sequence priorities
			fMoveContent(ApplicationFacade.NOTE_TIMELINE_MOVE);
		}

		public function fMoveContent(arg_s : String, arg_n: Number = 0) : void {
			for each (var oEra : AGTimelineEra in _aEras) {
				oEra.fMoveContent(arg_s, arg_n);
			}
		}
		
		public function fToggleSpecificTimeline(arg_s:String, arg_b : Boolean) : void {
			var t_nAlpha: Number = (arg_b) ? 1 : 0;
			var t_i : int = ArrayUtils.INDEXOF(TIMELINE_NAMES, arg_s);
			for each (var oElement : AGTimeLineElementsBase in _aTimelineElements[t_i]) {
				TweenMax.to(oElement, ApplicationFacade.TWEEN_DURATION, {autoAlpha: t_nAlpha});
				oElement.theEnabled = arg_b;
			}
		}

		public function fActivateEvent() : void {
			if (_bLoading) {
				// loading still in progress
				if (_aAllEventGFX[ApplicationFacade.ACTIVE_ITEM_ID] == null) {
					// silhouette doesn't exist
					_bInteruptSequence = true;
					(_aEras[ApplicationFacade.CURRENT_ERA_IN_VIEW] as AGTimelineEra).fLoadActiveGraphic(); // bypass the silhouette and immediately load this png
				} 
				else {
					if (_aAllEventGFX[ApplicationFacade.ACTIVE_ITEM_ID].detailImage == null) _bInteruptSequence = true; // the png will need to be loaded
					(_aAllEventGFX[ApplicationFacade.ACTIVE_ITEM_ID] as AGTimelineEventGraphic).fToggle(true); // toggle the existing png
				}
			}
			else {
				if (_aAllEventGFX[ApplicationFacade.ACTIVE_ITEM_ID] != null) (_aAllEventGFX[ApplicationFacade.ACTIVE_ITEM_ID] as AGTimelineEventGraphic).fToggle(true); // toggle the existing png
				else {
					// logically, the silhouette should exist, but it doesn't so bypass the silhouette and immediately load this png 
					(_aEras[ApplicationFacade.CURRENT_ERA_IN_VIEW] as AGTimelineEra).fLoadActiveGraphic();
					_bLoading = true; // AND kickstart loading again
				}
			}
			////////			
			// toggle label
			if (_aAllLabels[ApplicationFacade.ACTIVE_ITEM_ID]) _aAllLabels[ApplicationFacade.ACTIVE_ITEM_ID].fToggle(true);
			// check for landscapes with PNGs
			if (_aLandscapePNGs[ApplicationFacade.ACTIVE_ITEM_ID]) {
				// NB png will only be loaded if that landscape element is already loaded ...
				for each (var o : AGTimelineLandscapeGraphic in _aLandscapePNGs[ApplicationFacade.ACTIVE_ITEM_ID]) {
					o.fAddDetail(); // need to load pngs to each
				}
			}
			// check for landscapes with animations
			if (_aLandscapeAnimations[ApplicationFacade.ACTIVE_ITEM_ID])
					(_aEras[ApplicationFacade.CURRENT_ERA_IN_VIEW] as AGTimelineEra).fLoadAnimations(_aLandscapeAnimations[ApplicationFacade.ACTIVE_ITEM_ID] as Array)
			// shift timeline content
			for each (var oEra : AGTimelineEra in _aEras) {
				TweenMax.to(oEra.theDrifters, ApplicationFacade.TIMELINE_TWEEN_DURATION, {x: 0, y:0});				TweenMax.to(oEra.theLabels, ApplicationFacade.TIMELINE_TWEEN_DURATION, {x: 0, y:0});
				oEra.fMoveContent(ApplicationFacade.NOTE_TIMELINE_MOVE);
			}
		}

		public function fHighlightEvent(arg_nID : Number, arg_sEvent: String): void {
			var t_nAlpha : Number = (arg_sEvent == "mouse_over") ? 0.8 : 0.6;
			var t_nScale : Number = (arg_sEvent == "mouse_over") ? 1.05 : 1;
			if (_aAllLabels[arg_nID]) {
				if (_aAllLabels[arg_nID].activated) t_nAlpha = 1;
				TweenMax.to(_aAllLabels[arg_nID], ApplicationFacade.TWEEN_DURATION, {autoAlpha: t_nAlpha, scaleX: t_nScale, scaleY: t_nScale});
			}						if (_aAllEventGFX[arg_nID]) TweenMax.to(_aAllEventGFX[arg_nID], ApplicationFacade.TWEEN_DURATION, {scaleX: t_nScale, scaleY: t_nScale});		}

//////// LOOKUPS		
		private function fLookupNextClosestEra(arg_a : Array) : int {
			arg_a.splice(ArrayUtils.INDEXOF(arg_a, _oCurrentEraPopulating),1);
			var t_i : int = -1;
			var t_nDifference : Number = 100000; // arbitrary big number (more than the total number of eras)
			for (var i: int = 0; i< arg_a.length; i++){
				if (Math.abs(_oCurrentEraPopulating.chronolgicalPosition - (arg_a[i] as AGTimelineEra).chronolgicalPosition) < t_nDifference) {
					t_i = (arg_a[i] as AGTimelineEra).chronolgicalPosition;
					t_nDifference = Math.abs(_oCurrentEraPopulating.chronolgicalPosition - (arg_a[i] as AGTimelineEra).chronolgicalPosition);
				}
			}
			return t_i;
		}
		
////// GETTER SETTERS
		public function get timelineElements() : Array {
			return _aTimelineElements;
		}
		
		public function set landscapeVO(arg_oLandscapeVO : AGLandscapeVO) : void {
			_oTimelineLandscapeVO = arg_oLandscapeVO;
			if (_oTimelineVO != null) fInitLandscape(); // if it is null, the function will be called when _oTimelineVO is available (fInitLoadingSequence)
		}
				
		public function get eraDisplayObjects() : Array {
			return _aEras;
		}
		
		public function get allEventGFX() : Array {
			return _aAllEventGFX;
		}
		
		public function get allLabels() : Array {
			return _aAllLabels;
		}
		
		public function get isLoading() : Boolean {
			return _bLoading;
		}
		
		public function get mcGradient() : AGTimelineGradient {
			return _mcGradient;
		}
	}
}
