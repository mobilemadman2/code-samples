package net.believecollective.ag2010.view.timeline.components {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.events.AGTimelineElementEvent;
	import net.believecollective.ag2010.model.vo.timeline.dates.AGDatesVO;
	import net.believecollective.ag2010.model.vo.timeline.eras.AGEraSceneVO;
	import net.believecollective.ag2010.model.vo.timeline.eras.AGEraVO;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimeLineElementsBase;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimelineDates;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimelineEraMask;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimelineEventGraphic;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimelineEventLabel;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimelineLandscapeGraphic;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.dividerelements.AGDividerLayer;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.dividerelements.AGDividerVO;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.dividerelements.AGTimelineEraDividerBG;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.dividerelements.AGTimelineEraDividerEmblem;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.dividerelements.AGTimelineEraDividerSubtitle;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.dividerelements.AGTimelineEraDividerText;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.dividerelements.AGTimelineEraDividerTitle;
	import net.believecollective.utils.ArrayUtils;
	import net.believecollective.utils.Tracer;

	import com.greensock.TweenMax;
	import com.greensock.easing.StrongFast;

	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author Marianne
	 * 
	 * Container class for all the Timelinelayers for a specific era
	 * sets the depth (index) of each child (AGTimelineLayer)
	 * controls loading order of TimelineElements (children's children) for specific era , prioritised according to _nFocusYear 
	 * mediates the horizontal shift of childrens' children (AGTinelineElementsBase)
	 * this.parent (TimelineViewGFX) moves this in and out of the visible application area  
	 */
	 
	public class AGTimelineEra extends MovieClip {

		// vars
		private var _iChronolgicalPosition : int; // the chronolgical position of the era (zero based) 
		private var _oVO : AGEraVO; // data pulled from CMS
		private var _nEraStartX: Number;
		private var _nEraEndX: Number;
		
		// arrays used in sequential loading
		private var _iLabel : int;
		private var _aEvents : Array; // references EventVOs
		private var _aDivider : Array; // references sceneryVOs for the furthest layer
		private var _aSky : Array; // references sceneryVOs for the furthest layer
		private var _aScenery : Array; // references SceneryVOs		private var _aSilhouettes: Array; // references silhouette display objects - used for sequenital loading of image detail
		
		private var _mcBG : Sprite;		
		// container classses
		private var _mcDrifters : MovieClip;
		private var _aTimelineLayers : Array; // array of display objects (containers)
		
		private var _mcBackground0 : AGTimelineLayer; // backmost layer (eg , xml depth 12		private var _mcBackground1 : AGTimelineLayer; // reserved for distant BG (mountains etc) , xml depth 11
		
		private var _mcForeground1 : AGTimelineLayer; // pinned sillhouettes , xml depth 10
		private var _mcForeground2 : AGTimelineLayer; // pinned sillhouettes , xml depth 9
		private var _mcForeground3 : AGTimelineLayer; // pinned sillhouettes , xml depth 8
		private var _mcForeground4 : AGTimelineLayer; // pinned sillhouettes , xml depth 7
		private var _mcForeground5 : AGTimelineLayer; // pinned sillhouettes , xml depth 6
		private var _mcForeground6 : AGTimelineLayer; // pinned sillhouettes , xml depth 5
		private var _mcForeground7 : AGTimelineLayer; // pinned sillhouettes , xml depth 4
		private var _mcForeground8 : AGTimelineLayer; // pinned sillhouettes , xml depth 3
		
		private var _mcFloatingSilhouettes : AGTimelineLayer; // silhouettes only , xml depth 2
		private var _mcFloatingForeground : AGTimelineLayer; // mainly scenery but may occasionally container event graphics , xml depth 1
		private var _mcFloatingLabels : AGTimelineLayer; // labels only		private var _mcDates : AGTimelineLayer; // labels only
		private var _mcMasks : AGTimelineLayer; // mask only - this layer must not contain any 3d objects		private var _mcOverlay : AGTimelineLayer;
		
		private var _mcDividerBackGround : AGDividerLayer;
		private var _mcDividerEmblem : AGDividerLayer;
		private var _mcDividerTextPanel : AGDividerLayer;
		private var _mcDividerTitle : AGDividerLayer;
				
		public function AGTimelineEra(arg_oVO : AGEraVO) {
			this.x = ApplicationFacade.HORIZONTAL_FOCUS_POINT;
			_iLabel = 0;
			_aEvents = new Array();
			_aDivider = new Array();
			_aSky = new Array();
			_aScenery = new Array();			_aSilhouettes = new Array();
			// retrieve data from the vo
			_oVO = arg_oVO;
			_iChronolgicalPosition = arg_oVO.chronologicalPosition;
			for each (var oEvent : AGEventVO in _oVO.events) {
				_aEvents.push(oEvent);
			}
			_nEraStartX = _oVO.eraStartX;
			_nEraEndX = _oVO.eraEndX;		
			// divider
			_aDivider.push(	new AGDividerVO(_oVO.eraName, _nEraStartX, _iChronolgicalPosition, 0), 
							new AGDividerVO(_oVO.eraName, _nEraStartX, _iChronolgicalPosition, 1),
							new AGDividerVO(_oVO.eraName, _nEraStartX, _iChronolgicalPosition, 2),							new AGDividerVO(_oVO.dateText, _nEraStartX, _iChronolgicalPosition, 2),
							new AGDividerVO(_oVO.introText, _nEraStartX, _iChronolgicalPosition, 3));
//			_aDivider.push(	new AGDividerVO(_oVO.eraName, 0, _iChronolgicalPosition, 0), 
//							new AGDividerVO(_oVO.eraName, 0, _iChronolgicalPosition, 1),
//							new AGDividerVO(_oVO.eraName, 0, _iChronolgicalPosition, 2),
//							new AGDividerVO(_oVO.dateText, 0, _iChronolgicalPosition, 2),
//							new AGDividerVO(_oVO.introText, 0, _iChronolgicalPosition, 3));
			
			// ADD THE CONTAINER CLASSES
			_aTimelineLayers = new Array();
			// masks (and BG)
			_mcMasks = addChild(new AGTimelineLayer()) as AGTimelineLayer;
			_mcBackground0 = addChild(new AGTimelineLayer()) as AGTimelineLayer;
			_mcOverlay = addChild(new AGTimelineLayer()) as AGTimelineLayer;
			// drifters
			_mcDrifters = addChild(new MovieClip()) as MovieClip;
			_mcBackground1 = _mcDrifters.addChild(new AGTimelineLayer()) as AGTimelineLayer;
			_mcForeground1 = _mcDrifters.addChild(new AGTimelineLayer()) as AGTimelineLayer;
			_mcForeground2 = _mcDrifters.addChild(new AGTimelineLayer()) as AGTimelineLayer;
			_mcForeground3 = _mcDrifters.addChild(new AGTimelineLayer()) as AGTimelineLayer;
			_mcForeground4 = _mcDrifters.addChild(new AGTimelineLayer()) as AGTimelineLayer;
			_mcForeground5 = _mcDrifters.addChild(new AGTimelineLayer()) as AGTimelineLayer;
			_mcForeground6 = _mcDrifters.addChild(new AGTimelineLayer()) as AGTimelineLayer;
			_mcForeground7 = _mcDrifters.addChild(new AGTimelineLayer()) as AGTimelineLayer;
			_mcForeground8 = _mcDrifters.addChild(new AGTimelineLayer()) as AGTimelineLayer;
			_mcFloatingSilhouettes = _mcDrifters.addChild(new AGTimelineLayer()) as AGTimelineLayer;
			_mcFloatingForeground = _mcDrifters.addChild(new AGTimelineLayer()) as AGTimelineLayer;			// dividers
			_mcDividerBackGround = addChild(new AGDividerLayer()) as AGDividerLayer;
			_mcDividerEmblem = addChild(new AGDividerLayer()) as AGDividerLayer;
			_mcDividerTextPanel = addChild(new AGDividerLayer()) as AGDividerLayer;
			_mcDividerTitle = addChild(new AGDividerLayer()) as AGDividerLayer;
			//dates and labels
			_mcDates = addChild(new AGTimelineLayer()) as AGTimelineLayer; 
			_mcFloatingLabels = addChild(new AGTimelineLayer()) as AGTimelineLayer; // this layer also drifts but is not contained by mcDrifters because the dates layer needs to lie between them
			// add containers to the array
			_aTimelineLayers.push(_mcBackground0);
			_aTimelineLayers.push(_mcBackground1);
			_aTimelineLayers.push(_mcForeground1);
			_aTimelineLayers.push(_mcForeground2);
			_aTimelineLayers.push(_mcForeground3);
			_aTimelineLayers.push(_mcForeground4);
			_aTimelineLayers.push(_mcForeground5);
			_aTimelineLayers.push(_mcForeground6);
			_aTimelineLayers.push(_mcForeground7);
			_aTimelineLayers.push(_mcForeground8);
			_aTimelineLayers.push(_mcFloatingSilhouettes);
			_aTimelineLayers.push(_mcFloatingForeground);
			_aTimelineLayers.push(_mcFloatingLabels);			_aTimelineLayers.push(_mcDates);
			_aTimelineLayers.push(_mcDividerBackGround);
			_aTimelineLayers.push(_mcDividerEmblem);
			_aTimelineLayers.push(_mcDividerTextPanel);
			_aTimelineLayers.push(_mcDividerTitle);
			_aTimelineLayers.push(_mcMasks);			_aTimelineLayers.push(_mcOverlay);
			_mcBackground0.scaleX = 7;
			_mcBackground0.scaleY = 7;
			_mcBackground0.y = -805;
			_mcBackground1.scaleX = 2;
			_mcBackground1.scaleY = 2;
			// create masks and tinted objects
			_mcBG = _mcMasks.fAddElement(AGTimelineEraMask.NAME, new AGEventVO(-1, "", "", "", "", true, 0, _nEraStartX, _nEraEndX - _nEraStartX, 0, "", "", "", true, false)) as AGTimelineEraMask;			_mcOverlay.fAddElement(AGTimelineEraMask.NAME, new AGEventVO(-1, "", "", "", "", true, 0, _nEraStartX, _nEraEndX - _nEraStartX, 0, "", "", "", true, false)) as AGTimelineEraMask;
			TweenMax.to(_mcBG, 0, {autoAlpha: 0}); // awaiting colour info from landscape xml			TweenMax.to(_mcOverlay, 0, {autoAlpha: 0}); // awaiting info data from landscape xml
			_mcDrifters.mask = _mcMasks.fAddElement(AGTimelineEraMask.NAME, new AGEventVO(-1, "", "", "", "", true, 0, _nEraStartX, _nEraEndX - _nEraStartX, 0, "", "", "", true, false)) as AGTimelineEraMask;
			_mcBackground0.mask = _mcMasks.fAddElement(AGTimelineEraMask.NAME, new AGEventVO(-1, "", "", "", "", true, 0, _nEraStartX, _nEraEndX - _nEraStartX, 0, "", "", "", true, false)) as AGTimelineEraMask;		
		}

		public function fTint(arg_oVO : AGEraSceneVO) : void {
			TweenMax.to(_mcBG, 0, {tint : arg_oVO.bgTint, autoAlpha : arg_oVO.bgAlpha});			TweenMax.to(_mcOverlay, 0, {tint : arg_oVO.overlayTint, autoAlpha : arg_oVO.overlayAlpha});
		}

		//////// loading sequence
		
		public function fAddNextLabel() : AGTimelineEventLabel {
			if (_iLabel >= _aEvents.length)return null; // all the labels for this era have been added
			else {
				// add the next label
				var t_oTimelineLabel : AGTimelineEventLabel = _mcFloatingLabels.fAddElement(AGTimelineEventLabel.NAME, _aEvents[_iLabel]) as AGTimelineEventLabel;
				_iLabel ++;
			}
			return t_oTimelineLabel;
		}

		public function fAddNextBGGraphic() : void {
			switch (_aDivider.length) {
				case 5 :	
					_mcDividerBackGround.fAddElement(AGTimelineEraDividerBG.NAME, _aDivider[0] as AGDividerVO) as AGTimelineEraDividerBG;
					_aDivider.shift();
					break;
				case 4:
					_mcDividerEmblem.fAddElement(AGTimelineEraDividerEmblem.NAME, _aDivider[0] as AGDividerVO);
					_mcDividerTitle.fAddElement(AGTimelineEraDividerTitle.NAME, _aDivider[1] as AGDividerVO) as AGTimelineEraDividerTitle;					_mcDividerTitle.fAddElement(AGTimelineEraDividerSubtitle.NAME, _aDivider[2] as AGDividerVO) as AGTimelineEraDividerSubtitle;
					_mcDividerTextPanel.fAddElement(AGTimelineEraDividerText.NAME, _aDivider[3] as AGDividerVO) as AGTimelineEraDividerText;					_aDivider = [];
					var t_aDates : Array =  _oVO.dateMarkings;
					for each (var oVO : AGDatesVO in t_aDates) {
						_mcDates.fAddElement(AGTimelineDates.NAME, oVO);					}
					break;
				case 0:
					// divider is loaded, now load the sky
				 	if (_aSky.length == 0) {
						// this era contains no sky >> move onto next era
						dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED)); 
						return;
					}	
				// unlike the other landscape graphics, the sky is added in sequence it appears in the array
				_mcBackground0.fAddElement(AGTimelineLandscapeGraphic.NAME, _aSky.shift());
				break;
			}
		}

		public function fAddNextLandscapeGraphic() : Object {
			if (_aScenery.length == 0) {
				// this era contains no landscape >> move onto next era
				dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED)); 
				return null;
			}
			else {
				// find the nearest (unloaded) event to the focus 
				var t_i : int = fGetNearestObject(_aScenery);
				// lookup the correct container (controls paralax and depth)
				var t_oContainer : AGTimelineLayer = fLookupContainer(_aScenery[t_i].layer);
				if (t_oContainer == null) {
					// this graphic will not be loaded, emmulate graphic loaded & remove VO from array
					Tracer.TRACE("!!!Marianne : AGTimelineEra.fAddNextLandscapeGraphic : landscape graphic has been assigned an invalid layer: " + _aScenery[t_i].eventName);
					_aScenery.splice(t_i, 1);
					dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED)); // emmulate graphic loaded
					return null;
				}
				// check if this is should be loaded immediately
				else if(!_aScenery[t_i].immediateload){
					// this event had no associated graphic, emmulate graphic loaded & remove VO from array
					var t_oVO : AGEventVO = _aScenery[t_i];
					_aScenery.splice(t_i, 1);
					dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED)); // emmulate graphic loaded
					return t_oVO; // return the VO to be stored for relevant event activation
				}
				else {
					//add a graphic to the correct layer
					var t_o : AGTimelineLandscapeGraphic = t_oContainer.fAddElement(AGTimelineLandscapeGraphic.NAME, _aScenery[t_i]) as AGTimelineLandscapeGraphic;
					t_oContainer.setChildIndex(t_o, 0); // fix for silhouettes hiding behind hills... 
					// remove VO from array
					_aScenery.splice(t_i, 1);
				}
			}
			return t_o;
		}

		public function fAddNextEventGraphic() : void {	
			if (_aEvents.length == 0) {
				 // this era contains no events >> move onto next era
				dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED));
				return;
			}
			// find the nearest unloaded event to the focus 
			var t_i : int = fGetNearestObject(_aEvents);
			// lookup the correct container (controls paralax and depth)
			var t_oContainer : AGTimelineLayer = fLookupContainer(_aEvents[t_i].layer);
			if (t_oContainer == null) {
				 // this event had no associated graphic, emmulate graphic loaded & remove VO from array
				_aEvents.splice(t_i, 1);
				dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED));
			}
			else {
				//add a graphic to the correct layer
				var t_oTimelineGraphic: AGTimeLineElementsBase = t_oContainer.fAddElement(AGTimelineEventGraphic.NAME, _aEvents[t_i]);
				// reference the graphic in the TimelineViewGFX class, according to the timeline section it belongs to (e.g. Nepal, Wales etc)
				var t_iTimelinePos : int = ArrayUtils.INDEXOF(TimelineViewGFX.TIMELINE_NAMES, t_oTimelineGraphic.timelineSection);
				((this.parent as TimelineViewGFX).timelineElements[t_iTimelinePos] as Array).push(t_oTimelineGraphic);
				// reference the silhouette here for adding detail later (chronological indexing) 
				if (!_aEvents[t_i].activated) _aSilhouettes.push(t_oTimelineGraphic);
				// reference the gfx in parent class indexed by eventID
				(this.parent as TimelineViewGFX).allEventGFX[t_oTimelineGraphic.eventID] = t_oTimelineGraphic;
				// remove VO from array
				_aEvents.splice(t_i, 1);
			}
		}
		
		public function fLoadActiveGraphic() : void {
			for each (var VO : AGEventVO in _aEvents) {
				if (VO.eventID == ApplicationFacade.ACTIVE_ITEM_ID){
					VO.activated = true;
					fAddNextEventGraphic();
					return;
				}
			}
		}
		
		public function fLoadAnimations(arg_a : Array) : void {
			for each (var o : AGEventVO in arg_a) {
				var t_oContainer : AGTimelineLayer = fLookupContainer(o.layer);
				if (t_oContainer == null)
					// this graphic will not be loaded, emmulate graphic loaded & remove VO from array
					Tracer.TRACE("!!!Marianne : AGTimelineEra.fAddNextLandscapeGraphic : landscape animation has been assigned an invalid layer: " + o.eventName);
				else {
					//add a graphic to the correct layer
					var t_o : AGTimelineLandscapeGraphic = t_oContainer.fAddElement(AGTimelineLandscapeGraphic.NAME, o) as AGTimelineLandscapeGraphic;
				}
			}
		}

		public function fLoadNextEventDetailGraphic() : void {
			if (_aSilhouettes.length == 0) {
				 // this era contains no events >> move onto next era
				dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED));
				return;
			}
			// find the nearest unloaded image to the focus 
			var t_i : int = fGetNearestObject(_aSilhouettes);
			(_aSilhouettes[t_i] as AGTimelineEventGraphic).fAddDetail();
			_aSilhouettes.splice(t_i,1);
		}
		
/////// event associated functions
		
		public function fMoveContent(arg_s : String, arg_n : Number = 0) : void {
			switch (arg_s){
				case ApplicationFacade.NOTE_TIMELINE_MOVE :
				for each (var oLayer : AGTimelineLayer in _aTimelineLayers) {
//					TweenMax.to(oLayer, 2, {x : _nEraStartX - ApplicationFacade.CURRENT_X_IN_FOCUS, ease:StrongFast.easeOut});
					oLayer.fMoveContent();
				}
				break;
				case ApplicationFacade.NOTE_TIMELINE_BOUNCE:
//				for each (var oLayer : AGTimelineLayer in _aTimelineLayers) {
//					oLayer.fMoveContent();
//				}
				TweenMax.to(this, 0.1, {x:ApplicationFacade.HORIZONTAL_FOCUS_POINT + (arg_n/3), onComplete : fBounceBack});
				break;
			}
		}
		
		private function fBounceBack() : void {
			TweenMax.to(this, 1.2, {x: ApplicationFacade.HORIZONTAL_FOCUS_POINT, ease:StrongFast.easeOut});
			for each (var oLayer : AGTimelineLayer in _aTimelineLayers) {
				oLayer.x = 0;
				oLayer.fMoveContent();
			}
		}
	
//////// LOOKUPS

		private function fGetNearestObject(arg_a: Array): int {
			// arg_a references the objects which are still to be loaded
			// looks at the property startDate of each object in arg_a (could be AGEventVO or AGTimeLineElementsBase)
			// returns the index of the object which is closeswt to the current focus point 
			var t_aDistances: Array = new Array;
			var t_aSorted : Array = new Array;
			if (arg_a[0] is AGTimeLineElementsBase){
				for (var i:int = 0; i < arg_a.length ; i++) {
					if (arg_a[i] != null) t_aDistances[i] = t_aSorted[i] = Math.abs(arg_a[i].xAxis - ApplicationFacade.CURRENT_X_IN_FOCUS);
				}
			} else {
				for (var i:int = 0; i < arg_a.length ; i++) {
					if (arg_a[i] != null) t_aDistances[i] = t_aSorted[i] = Math.abs(arg_a[i].xAxisPosition - ApplicationFacade.CURRENT_X_IN_FOCUS);
				}
			}
			t_aSorted.sort(Array.NUMERIC);
			return ArrayUtils.INDEXOF(t_aDistances, t_aSorted[0]);
		}

		private function fLookupContainer(arg_ilevel : int) : AGTimelineLayer {
			switch(arg_ilevel){
				case 0:
					Tracer.TRACE("!!!Marianne : AGTimelineEra.fLookupContainer : this event has no graphic ");
					return null; // this event has no graphic!!
					break;
				case 1:
					return _mcFloatingForeground;
					break;
				case 2:
					return _mcFloatingSilhouettes;
					break;
				case 3:
					return _mcForeground8;
					break;
				case 4:
					return _mcForeground7;
					break;
				case 5:
					return _mcForeground6;
					break;
				case 6:
					return _mcForeground5;
					break;
				case 7:
					return _mcForeground4;
					break;
				case 8:
					return _mcForeground3;
					break;
				case 9:
					return _mcForeground2;
					break;
				case 10:
					return _mcForeground1;
					break;
				case 11:
					return _mcBackground1;
					break;
				case 12:
					return _mcBackground0;
					break;
				default:
					Tracer.TRACE("!!!Marianne : AGTimelineEra.fLookupContainer : ERROR - this graphic has been asssigned an invalid layer");
					return null;
					break;
			}
		}
		
		
//////// GETTER && SETTERS

		public function get chronolgicalPosition() : int {
			return _iChronolgicalPosition;
		}
		
		public function set scenery(arg_aSceneryVOs : Array) : void {
			_aScenery = arg_aSceneryVOs;
		}
		
		public function set sky(arg_aSkyVOs : Array) : void {
			_aSky = arg_aSkyVOs;
		}
		
		public function get sky() : Array {
			return _aSky;
		}
		
		public function get divider() : Array {
			return _aDivider;
		}
		
		public function get scenery() : Array {
			return _aScenery;
		}
		
		public function get events() : Array {
			return _aEvents;
		}
		
		public function get silhouettes() : Array {
			return _aSilhouettes;
		}
		
		public function get eraEndX() : Number {
			return _nEraEndX;
		}
		
		public function get eraStartX() : Number {
			return _nEraStartX;
		}
		
		public function get theDrifters() : MovieClip {
			return _mcDrifters;
		}
		
		public function get theLabels() : AGTimelineLayer {
			return _mcFloatingLabels;
		}
	}
}
