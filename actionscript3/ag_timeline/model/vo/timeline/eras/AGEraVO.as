
package net.believecollective.ag2010.model.vo.timeline.eras {
	import net.believecollective.ag2010.model.vo.timeline.dates.AGDatesVO;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;
	import net.believecollective.ag2010.patterns.proxy.HistoryProxy;
	import net.believecollective.ag2010.view.timeline.components.TimelineViewGFX;
	import net.believecollective.model.StandardConfig;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class AGEraVO extends StandardConfig {
		
		//vars
		private var _aEvents : Array;
		private var _sName : String;		private var _sDates : String;		private var _sIntro : String;
		private var _iChronologicalPosition : int;
		private var _aDateMarkings : Array; // an array of date VOs for the timelineViewGFX to add markings
		
		private var _nPseudoStartYear : Number;		private var _nLiteralStartYear : Number;
		private var _nEraStartX : Number;
		private var _nPseudoEndYear : Number;		private var _nLiteralEndYear : Number;
		private var _nEraEndX : Number;
		private var _nEraWidth : Number;
				
		protected var _oHistory : HistoryProxy;		
		public function AGEraVO	(
									arg_xXML:XML,
									arg_iChronolgicalPos : int,
									arg_oHistory : HistoryProxy,
									arg_sDates : String = "",									arg_sIntroText : String = "",
									arg_oDateData : EraStructureVO = null
								) {
			_oHistory = arg_oHistory;
			_aEvents = new Array();	
			_sName = arg_xXML.@name;
			_iChronologicalPosition = arg_iChronolgicalPos;
			_sDates = arg_sDates;			_sIntro = arg_sIntroText;

			_nPseudoStartYear = arg_oDateData.startYear;
			_nPseudoEndYear = arg_oDateData.endYear;
			_nEraWidth = arg_oDateData.width;
			_nEraStartX = arg_oDateData.startX;
			_nEraEndX = _nEraStartX + _nEraWidth;
			if (_sDates != ""){
				var t_sStartYear : String = _sDates.split(" - ")[0];				var t_sEndYear : String =  _sDates.split(" - ")[1];
				_nLiteralStartYear = Number(t_sStartYear.split(" ")[0]);				_nLiteralEndYear = Number(t_sEndYear.split(" ")[0]);
				if (t_sStartYear.split(" ")[1] == "BCE") _nLiteralStartYear *= -1;				if (t_sEndYear.split(" ")[1] == "BCE") _nLiteralEndYear *= -1;
			}
			// events
			fCreateEvents(arg_xXML);
			// date markings
			_aDateMarkings = new Array();
			var t_nNum : Number = ((arg_oDateData.lastYear - arg_oDateData.firstYear) / arg_oDateData.rulerSeperation) + 1;
			for (var i : int = 0; i< t_nNum; i++) {
				var t_s : String = String(arg_oDateData.firstYear + (arg_oDateData.rulerSeperation *i));
				var t_nYearWidth : Number = _nEraWidth / (_nPseudoEndYear - _nPseudoStartYear);
				var t_nYearX : Number = (arg_oDateData.firstYear + (arg_oDateData.rulerSeperation *i) - _nPseudoStartYear) * t_nYearWidth;
				var t_o : AGDatesVO = new AGDatesVO(t_s, _nEraStartX + t_nYearX);
				t_o.chronologicalPosition = _iChronologicalPosition;
				_aDateMarkings.push(t_o);
			}
		}

		protected function fCreateEvents(arg_xXML : XML) : void {
			var t_aEvents: Array = new Array();			var t_aHistory : Array = _oHistory.historyObject.data.eventIDs;			var t_aVisibilty : Array = _oHistory.historyObject.data.timelinesVis;
			var t_a: Array = TimelineViewGFX.TIMELINE_NAMES;
			for (var i : int = 0; i < arg_xXML.timeline.length(); i++) {
				///
				var t_x:XML = arg_xXML.timeline[i] as XML;
				/// visibility determined by timeline section
				var t_s : String = t_x.@section;
				for (var j:int = 0; j< t_a.length; j++){
					if (t_a[j] == t_s){
						var t_bVis : Boolean = t_aVisibilty[j];
						break;
					}
				}
				/// activated determined by history
				var t_bAct : Boolean = false;
				for each (var n : Number in t_aHistory) {
					if (n == t_x.@id) {
						t_bAct = true;
						break;
					}
				}
				///
				var t_nX : Number = fLookupXPos(t_x.@from);
				var t_oEvent:AGEventVO = new AGEventVO	(
															t_x.@id, 
															t_x.@name, 															t_x.@alias, 															t_x.@from, 															t_x.@to, 															(t_x.@Factoid == 0) ? false : true,															t_x.@yaxis,
															t_nX,
															(t_x.@from == t_x.@to) ? 0 : fLookupWidth(t_x.@from, t_x.@to),
															t_x.@layer,															t_x.@section, 															t_x.@category, 															t_x.@URL,
															t_bVis,
															t_bAct
														);
				
				t_aEvents.push({vo:t_oEvent, nX: t_nX});			}	
			// put in chronological order
			t_aEvents.sortOn('nX',Array.NUMERIC);
			for each (var o : Object in t_aEvents) {
				_aEvents.push(o.vo);
				o.vo.chronologicalPosition = _aEvents.length -1;
			}				
		}
		
		protected function fLookupXPos(arg_sFrom : String) : Number {
			var t_sStartYear : String = arg_sFrom.substr(0,arg_sFrom.length - 6);
			var t_nStartYear : Number = Number(t_sStartYear);
//			var t_nYearWidth : Number = fLookupEraWidthPixel(_iChronologicalPosition) / (_nEraEndYear - _nEraStartYear);			var t_nYearWidth : Number = _nEraWidth / (_nPseudoEndYear - _nPseudoStartYear);
			var t_nYearX : Number = (t_nStartYear - _nPseudoStartYear) * t_nYearWidth;
			var t_nDay : int = fLookupDay(arg_sFrom);
			var t_nDayX : Number = t_nYearWidth * t_nDay / 365;
			return _nEraStartX + t_nYearX + t_nDayX;		}

		private function fLookupDay(arg_sFrom : String) : Number {
			if (arg_sFrom.substr(arg_sFrom.length - 5, 5) == "01-01") return 0;
			else {
				var t_nDay : Number;
				switch (Number(arg_sFrom.substr(arg_sFrom.length - 5, 2))){
					case 1:
						t_nDay = Number(arg_sFrom.substr(arg_sFrom.length - 2, 2)) -1;
						break;
					case 2:
						t_nDay = 31 + Number(arg_sFrom.substr(arg_sFrom.length - 2, 2)) -1;
						break;
					case 3:
						t_nDay = 59 + Number(arg_sFrom.substr(arg_sFrom.length - 2, 2)) -1;
						break;
					case 4:
						t_nDay = 90 + Number(arg_sFrom.substr(arg_sFrom.length - 2, 2)) -1;
						break;
					case 5:
						t_nDay = 120 + Number(arg_sFrom.substr(arg_sFrom.length - 2, 2)) -1;
						break;
					case 6:
						t_nDay = 151 + Number(arg_sFrom.substr(arg_sFrom.length - 2, 2)) -1;
						break;
					case 7:
						t_nDay = 181 + Number(arg_sFrom.substr(arg_sFrom.length - 2, 2)) -1;
						break;
					case 8:
						t_nDay = 212 + Number(arg_sFrom.substr(arg_sFrom.length - 2, 2)) -1;
						break;
					case 9:
						t_nDay = 243 + Number(arg_sFrom.substr(arg_sFrom.length - 2, 2)) -1;
						break;
					case 10:
						t_nDay = 273 + Number(arg_sFrom.substr(arg_sFrom.length - 2, 2)) -1;
						break;
					case 11:
						t_nDay = 304 + Number(arg_sFrom.substr(arg_sFrom.length - 2, 2)) -1;
						break;
					case 12:
						t_nDay = 334 + Number(arg_sFrom.substr(arg_sFrom.length - 2, 2)) -1;
						break;
				}
				return t_nDay;
			}
		}
		
		protected function fLookupWidth(arg_sFrom : String, arg_sTo : String) : Number {
			var t_sStartYear : String = arg_sFrom.substr(0,2);
			var t_nStartYear : Number = Number(t_sStartYear);
			var t_sEndYear : String = arg_sTo.substr(0,2);
			var t_nEndYear : Number = Number(t_sEndYear);
			var t_nWidth : Number = (t_nEndYear - t_nStartYear) * _nEraWidth / (_nPseudoEndYear - _nPseudoStartYear) ;
			return t_nWidth;
		}


		////////////////
		public function get eraName() : String {
			return _sName;
		}
		
		public function get chronologicalPosition() : int {
			return _iChronologicalPosition;
		}
		
		public function get eraStartX() : Number {
			return _nEraStartX;
		}
		
		public function get dateMarkings() : Array {
			return _aDateMarkings;
		}
		
		public function get pixelWidth() : Number {
			return _nEraWidth;
		}
		
		public function get eraEndX() : Number {
			return _nEraEndX;
		}
		
		public function get dateText() : String {
			return _sDates;
		}
		
		public function get introText() : String {
			return _sIntro;
		}
		
		public function get events() : Array {
			return _aEvents;
		}
		
		public function get pseudoStartYear() : Number {
			return _nPseudoStartYear;
		}
		
		public function get pseudoEndYear() : Number {
			return _nPseudoEndYear;
		}
		
		public function get realStartYear() : Number {
			return _nLiteralStartYear;
		}
		
		public function get realEndYear() : Number {
			return _nLiteralEndYear;
		}
		
	}
}
