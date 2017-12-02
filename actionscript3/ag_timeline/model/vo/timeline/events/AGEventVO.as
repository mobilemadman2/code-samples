
package net.believecollective.ag2010.model.vo.timeline.events {
	import net.believecollective.model.StandardConfig;
	import net.believecollective.utils.Tracer;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 * 
	 * used for timeline event labels , event graphics
	 * & landscape graphics
	 */ 
	public class AGEventVO extends StandardConfig {

		private var _nID : Number;
		private var _sName : String;
		private var _sAlias : String;
		private var _sFrom : String;
		private var _sTo : String;
		private var _bFactoid : Boolean;
		private var _nYAxis : Number;		private var _nXAxis : Number;		private var _nWidth : Number;
		private var _nLayer : Number;
		private var _sTimeline : String;
		private var _sImportance : String;
		private var _sURL : String;
		private var _iChronologicalPosition : int;		
		private var _bVisible : Boolean;		private var _bActivated : Boolean;		private var _bImmediateload : Boolean;
		
		public function AGEventVO	(
										arg_nID:Number,
										arg_sName:String,										arg_sAlias:String,										arg_sFrom:String,										arg_sTo:String,										arg_bFactoid:Boolean,										arg_nYAxis:Number,
										arg_nXAxis : Number,										arg_nWidth : Number,
										arg_nLayer:Number,										arg_sTimeline:String,										arg_sImportance:String,										arg_sURL:String,
										arg_bVisible : Boolean,										arg_bActivated : Boolean,
										arg_bImmediateload = true
									) {
										
			_nID = arg_nID;
			_sName = arg_sName;
			_sAlias = arg_sAlias;
			_sFrom = arg_sFrom;			_sTo = arg_sTo;
			_bFactoid = arg_bFactoid;
			_nYAxis = arg_nYAxis;			_nXAxis = arg_nXAxis;			_nWidth = arg_nWidth;
			_nLayer = arg_nLayer;
			_sTimeline = arg_sTimeline;
			_sImportance = arg_sImportance;
			_sURL = arg_sURL;
			_bVisible = arg_bVisible;			_bActivated = arg_bActivated;
			_bImmediateload = arg_bImmediateload;
		}

		public function get visible() : Boolean {
			return _bVisible;
		}
		
		public function get activated() : Boolean {
			return _bActivated;
		}
		
		public function set activated(arg_b : Boolean) : void {
			_bActivated = arg_b;
		}

		public function get eventID() : Number {
			return _nID;
		}
		
		public function get eventName() : String {
			return _sName;
		}
		
		public function get alias() : String {
			return _sAlias;
		}
		
		public function get from() : String {
			return _sFrom;
		}
		
		public function get to() : String {
			return _sTo;
		}
		
		public function get isFactoid() : Boolean {
			return _bFactoid;
		}
		
		public function get yAxisPosition() : Number {
			return _nYAxis;
		}
		
		public function get xAxisPosition() : Number {
			return _nXAxis;
		}
		
		public function get layer() : Number {
			return _nLayer;
		}
		
		public function get timelineID() : String {
			return _sTimeline;
		}
		
		public function get importanceID() : String {
			return _sImportance;
		}
		
		public function get eventURL() : String {
			if (_bFactoid) return null;
			else return _sURL;
		}
		
		
		public function fgetStartDate() : Number {
			return Number(_sFrom.substring(0, _sFrom.length-6));
		}
		
		public function fGetEndYear () : Number {
			return Number(_sTo.substring(0, _sTo.length-6));
		}
		
		public function set chronologicalPosition(arg_i : int) : void {
			_iChronologicalPosition = arg_i;
		}
		
		public function get chronologicalPosition() : int {
			return _iChronologicalPosition;
		}
		
		public function get width() : Number {
			return _nWidth;
		}
		
		public function fLookUpZIndex() : Number {
			switch(_nLayer) {
				case 0:
					Tracer.TRACE("!!!Marianne : AGEventVO.fLookUpZIndex : layer 0" );
					return 0; // this event has no graphic!!
					break;
				case 1:
					return 2;
					break;
				case 2:
					return 5;
					break;
				case 3:
					return 30;
					break;
				case 4:
					return 50;
					break;
				case 5:
					return 75;
					break;
				case 6:
					return 100;
					break;
				case 7:
					return 200;
					break;
				case 8:
					return 350;
					break;
				case 9:
					return 500;
					break;
				case 10:
					return 700;
					break;
				case 11:
					return 1300;
					break;
				case 12:
					return 5000;
					break;
				default:
					Tracer.TRACE("!!!Marianne : AGTimelineEra.fLookupContainer : ERROR - this graphic has been asssigned an invalid layer" + _sName);					return null;
					break;
			}
		}
		
		public function get immediateload() : Boolean {
			return _bImmediateload;
		}
	}
}
