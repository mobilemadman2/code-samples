package net.believecollective.ag2010.model.vo.timeline.eras {
	import net.believecollective.ag2010.model.vo.timeline.scenery.AGSceneryVO;
	import net.believecollective.ag2010.patterns.proxy.HistoryProxy;

	/**
	 * @author Marianne
	 */
	public class AGEraSceneVO extends AGEraVO {
		
		private var _aSky : Array;		private var _aScenery : Array;
		
		private var _nBGTint : Number;		private var _nBGAlpha : Number;		private var _nOverlayTint : Number;		private var _nOverlayAlpha : Number;
		
		public function AGEraSceneVO(arg_xXML : XML, arg_iChronologicalPos : int, arg_oHistory : HistoryProxy, arg_oDateData : EraStructureVO) {
			_aSky = new Array();				_aScenery = new Array();
			_nBGTint = arg_xXML.@bgTint;			_nBGAlpha = arg_xXML.@bgAlpha;			_nOverlayTint = arg_xXML.@overlayTint;			_nOverlayAlpha = arg_xXML.@overlayAlpha;
			super(arg_xXML,arg_iChronologicalPos,arg_oHistory,"","",arg_oDateData);
		}
		
		override protected function fCreateEvents(arg_xXML : XML) : void {
			var t_aHistory : Array = _oHistory.historyObject.data.eventIDs;
			for (var i : int = 0; i < arg_xXML.landscape.length(); i++) {
				var t_x:XML = arg_xXML.landscape[i] as XML;
				var t_bActivated : Boolean = false;
				for each (var oN : Number in t_aHistory) {
					if (t_x.@id == oN) t_bActivated = true;
					}
				var t_o:AGSceneryVO = new AGSceneryVO(
														t_x.@id,
														t_x.@alias, 
														t_x.@from,
														t_x.@yaxis,
														fLookupXPos(t_x.@from),
														t_x.@layer, 
														t_bActivated,
														(t_x.@immediate == 0) ? false : true
														);
				(t_x.@layer == 12) ? _aSky.push(t_o) : _aScenery.push(t_o);
			}
		}
		
		public function get scenery() : Array {
			return _aScenery;
		}
		
		public function get sky() : Array {
			return _aSky;
		}
		
		public function get bgTint() : Number {
			return _nBGTint;
		}
		
		public function get bgAlpha() : Number {
			return _nBGAlpha;
		}
		
		public function get overlayTint() : Number {
			return _nOverlayTint;
		}
		
		public function get overlayAlpha() : Number {
			return _nOverlayAlpha;
		}
	}
}
