
package net.believecollective.ag2010.model.vo.timeline {
	import net.believecollective.ag2010.model.vo.timeline.eras.AGEraVO;
	import net.believecollective.model.StandardConfig;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class AGTimelineVO extends StandardConfig {

		protected var _aEras : Array;
		
		public function AGTimelineVO() {
			_aEras = new Array();
		}
		
		public function fAddEra(arg_vo:AGEraVO):void {
			_aEras.push(arg_vo);
		}
		
		public function get eras() : Array {
			return _aEras;
		}
		
	}
}
