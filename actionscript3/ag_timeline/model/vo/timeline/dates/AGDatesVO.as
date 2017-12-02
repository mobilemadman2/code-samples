package net.believecollective.ag2010.model.vo.timeline.dates {
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;

	/**
	 * @author Marianne
	 */
	public class AGDatesVO extends AGEventVO {
		
		public function AGDatesVO(arg_sText : String , arg_nX : Number) {
			super(-1, arg_sText, "", "", "",true, 0, arg_nX, 0, 0, "", "", "", true, false);
		}
	}
}
