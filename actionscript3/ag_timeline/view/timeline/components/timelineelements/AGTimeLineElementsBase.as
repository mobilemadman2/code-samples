package net.believecollective.ag2010.view.timeline.components.timelineelements {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.events.AGTimelineElementEvent;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;
	import net.believecollective.event.ButtonEvent;

	import com.greensock.TweenMax;
	import com.greensock.easing.StrongFast;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author Marianne
	 *  any sprite or movieclip which should move (with paralax) within the timelineView
	 */
	 
	public class AGTimeLineElementsBase extends MovieClip {
		
		protected var _oVO : AGEventVO;
		protected var _sTimeline: String;		
		protected var _bFactoid : Boolean;		protected var _bActivated : Boolean;
		protected var _nEventID : Number;
		
		protected var _nXAxis : Number;
		
		protected var _iChronolgicalPosition : int;
		
		protected var _bEnabled : Boolean; // set in children!!!
		protected var _nTargetX : Number;
		
		protected var _sFilePath : String;
		
		public function AGTimeLineElementsBase(arg_oVO: AGEventVO) {
			_oVO = arg_oVO;
			//Add Button behavior to this Sprite
			ButtonEvent.makeButton(this);
			
			this.buttonMode = true;
			this.mouseChildren = false;
			fInit();
		}

		protected function fInit() : void {
			_iChronolgicalPosition = _oVO.chronologicalPosition;
			_sTimeline = _oVO.timelineID;
			_bFactoid = _oVO.isFactoid;
			_nEventID = _oVO.eventID;
			_bActivated = _oVO.activated;
			this.y = _oVO.yAxisPosition;
			_nXAxis = _oVO.xAxisPosition;
			fAddGraphics();
		}

		protected function fAddGraphics() : void {
		// override 
		}

		private function fClick(event : Event) : void {
			dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_EVENT_CLICK));
		}

		public function fAddDetail() : void {
		// override 
		}

		public function fToggle(arg_b: Boolean): void {
		// override
		}
		
		public function get timelineSection() : String {
			return _sTimeline;
		}
		
		public function get chronolgicalPosition() : int {
			return _iChronolgicalPosition;
		}
		
		public function set theEnabled(bEnabled : Boolean) : void {
			_bEnabled = bEnabled;
			if (_bEnabled){
				this.buttonMode = true;
				this.useHandCursor = true;
				addEventListener(MouseEvent.CLICK, fClick);
				addEventListener(ButtonEvent.RELEASE_OUTSIDE, fClick);
			} else {
				this.buttonMode = false;
				this.useHandCursor = false;
				removeEventListener(MouseEvent.CLICK, fClick);
				removeEventListener(ButtonEvent.RELEASE_OUTSIDE, fClick);
			}
		}
		
		public function get targetX() : Number {
			return _nTargetX;
		}
		
		public function set targetX(arg_nTargetX : Number) : void {
			_nTargetX = arg_nTargetX;			TweenMax.to(this, 2* ApplicationFacade.TIMELINE_TWEEN_DURATION, {x : _nTargetX, ease:StrongFast.easeOut});
		}
		
		override public function set x(arg_nX : Number) : void {
			super.x = _nTargetX = arg_nX;
		}
		
		public function get xAxis() : Number {
			return _nXAxis;
		}
		
		public function get activated () : Boolean {
			return _bActivated;
		}

		public function set xAxis(nXAxis : Number) : void {
			_nXAxis = nXAxis;
		}
		
		public function get eventID() : Number {
			return _nEventID;
		}
		
	}
}
