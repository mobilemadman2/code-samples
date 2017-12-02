
package net.believecollective.ag2010.model.vo {
	import net.believecollective.ag2010.model.vo.timeline.eras.EraStructureVO;
	import net.believecollective.model.StandardConfig;
	import net.believecollective.model.vo.InterfaceLanguageVO;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class AGConfigVO extends StandardConfig {

		private var aViewsTextIDs : Array;
		private var aViewsTextObjects : Array;
		private var _nMaxAppWidth : Number;
		private var _nMaxAppHeight : Number;
		private var _bTestMode : Boolean;
		private var _bTooltipsExist : Boolean;		private var _bTooltipsOn : Boolean;
		private var _bUselocalxml : Boolean;
		private var aEraIDs : Array;
		private var aEraDateData : Array;
		
		public function AGConfigVO() {
			aViewsTextIDs = new Array();			aEraIDs = new Array();
			aViewsTextObjects = new Array();			aEraDateData = new Array();
			_bTooltipsOn = true;
		}

		public function fAddLangID(arg_s : String) : void {
			aViewsTextIDs.push(arg_s);
		}

		public function fAddLangObject(arg_o : InterfaceLanguageVO) : void {
			aViewsTextObjects.push(arg_o);
		}
		
		public function fAddEraID(arg_s : String) : void {
			var t_n : Number = Number(arg_s.substr(arg_s.length-1));
			aEraIDs[t_n-1] = arg_s;
		}

		public function fAddEraObjects(arg_o : EraStructureVO) : void {
			var t_n : Number = Number(arg_o.theID.substr(arg_o.theID.length-1));
			aEraDateData[t_n-1] = arg_o;
		}

		public function get viewIDs() : Array {
			return aViewsTextIDs;
		}	

		public function get viewInterfaceTextObjects() : Array {
			return aViewsTextObjects;
		}

		public function get maxAppHeight() : Number {
			return _nMaxAppHeight;
		}
		public function set maxAppHeight(arg_n : Number) : void {
			_nMaxAppHeight = arg_n;
		}

		public function get maxAppWidth() : Number {
			return _nMaxAppWidth;
		}
		public function set maxAppWidth(arg_n : Number) : void {
			_nMaxAppWidth = arg_n;
		}
		
		public function get testmode() : Boolean {
			return _bTestMode;
		}
		public function set testmode(arg_b : Boolean) : void {
			_bTestMode = arg_b;
		}

//		public function get uselocalxml() : Boolean {
//			return _bUselocalxml;
//		}
		public function set uselocalxml(arg_b : Boolean) : void {
			_bUselocalxml = arg_b;
		}
		
		public function get tooltips() : Boolean {
			return _bTooltipsExist;
		}
		public function set tooltips(arg_b : Boolean) : void {
			_bTooltipsExist = arg_b;
		}
		
		public function get tooltipsOn() : Boolean {
			return _bTooltipsOn;
		}
		public function set tooltipsOn(arg_b : Boolean) : void {
			_bTooltipsOn = arg_b;
		}
		
		public function get eraIDs() : Array {
			return aEraIDs;
		}
		
		public function get eraDateData() : Array {
			return aEraDateData;
		}
	}
}
