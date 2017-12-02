package net.believecollective.ag2010.view.timeline.components.timelineelements.dividerelements {
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimeLineElementsBase;

	/**
	 * @author Marianne
	 */
	public class AGTimelineDividerBase extends AGTimeLineElementsBase {
		public function AGTimelineDividerBase(arg_oVO : AGEventVO) {
			super(arg_oVO);
		}
		
		override protected function fInit() : void {
			_iChronolgicalPosition = _oVO.chronologicalPosition;
			_nXAxis = _oVO.xAxisPosition;
			this.alpha = 0;
			this.z = _oVO.fLookUpZIndex();
			fAddGraphics();
		}
		
	}
}
