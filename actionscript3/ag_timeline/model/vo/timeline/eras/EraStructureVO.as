package net.believecollective.ag2010.model.vo.timeline.eras {
	import net.believecollective.model.StandardConfig;

	/**
	 * @author Marianne
	 */
	public class EraStructureVO extends StandardConfig{
	
	private var _nStartYear : Number;	private var _nEndYear : Number;	private var _nWidth : Number;	private var _nFirstYear : Number;	private var _nLastYear : Number;	private var _nRulerSeperation : Number;
	private var _nStartX : Number;
	
	private var _sID : String;
	
	public function EraStructureVO(
									arg_xml : XML
	
	) : void {
		
			_sID = arg_xml.@original;
			var t_xList : XMLList = arg_xml.elements().elements();
			for (var i : Number = 0;i < t_xList.length(); i++) {
				switch (String(t_xList[i].@ID)){
					case "StartYear" :
						_nStartYear = t_xList[i];
						break;
					case "EndYear" :
						_nEndYear = t_xList[i];
					break;
					case "PixelWidth" :
						_nWidth = t_xList[i];
					break;
					case "FirstDate" :
						_nFirstYear = t_xList[i];
					break;
					case "LastDate" :
						_nLastYear = t_xList[i];
					break;
					case "RulerSeparation" :
						_nRulerSeperation = t_xList[i];
					break;
				}
			}
		}
		
		public function get startYear() : Number {
			return _nStartYear;
		}
		
		public function get endYear() : Number {
			return _nEndYear;
		}
		
		public function get width() : Number {
			return _nWidth;
		}
		
		public function get firstYear() : Number {
			return _nFirstYear;
		}
		
		public function get lastYear() : Number {
			return _nLastYear;
		}
		
		public function get rulerSeperation() : Number {
			return _nRulerSeperation;
		}
		
		public function get startX() : Number {
			return _nStartX;
		}
		
		public function set startX(nStartX : Number) : void {
			_nStartX = nStartX;
		}
		
		public function get theID() : String {
			return _sID;
		}
	}
}
