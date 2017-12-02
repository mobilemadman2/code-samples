package net.believecollective.ag2010.model.vo {
	import flash.geom.Point;

	/**
	 * @author Marianne
	 */			 
	public class AGTooltipVO {
			 
		private var _sID : String;
		private var _sArrowPos : String;		private var _sTextPos : String;		private var _sText : String;		private var _bBG : Boolean;
		private var _oPos : Point;
		
		public function AGTooltipVO(			
												arg_sID : String = "", // lang xml content ID. If this is blank, arg_sDynamicText is used
												arg_sDynamicText : String = "", // example usage : nav-bar dates rollover
												arg_sArrowPos : String = "right", // can be "right", "left", "top" , "bottom"
												arg_oPos : Point = null, // arrow coordinates
												arg_sTextPos : String = "", // can be specified as "center", "left", "right" 
																					// DEFAULT TEXT POSITIONS: 
																					// left for left positioned arrow; 
																					// right for right positioned arrow;
																					// center for top or bottom positioned arrow
												arg_BG : Boolean = true
												) : void {
						
			_sID = arg_sID;
			_oPos = (arg_oPos == null) ? new Point(0,0) : arg_oPos;
			_sArrowPos = arg_sArrowPos;			_sTextPos = arg_sTextPos;
			_bBG = arg_BG;
			if (arg_sDynamicText != "") _sText = arg_sDynamicText;
			// else it will be retrieved form the language interface VO ( controlled by languaage xml)
		}	
		
		public function get position() : String {
			return _sArrowPos;
		}
		
		public function get textPosition() : String {
			return _sTextPos;
		}
		
		public function get theText() : String {
			return _sText;
		}
		
		public function set theText(arg_sText : String) : void {
			_sText = arg_sText;
		}
		
		public function get theID() : String {
			return _sID;
		}
		
		public function get hasBG() : Boolean {
			return _bBG;
		}
		
		public function get point() : Point {
			return _oPos;
		}	
	}
}
