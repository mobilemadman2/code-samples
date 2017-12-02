package net.believecollective.ag2010.view.timeline.components.timelineelements {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;

	import flash.display.Sprite;

	/**
	 * @author Marianne
	 */
	public class AGTimelineEraBG extends AGTimelineEraMask {
		
		public static const NAME : String = "AGTimelineEraMask";
		
		public function AGTimelineEraBG(arg_oVO: AGEventVO) {
			super(arg_oVO);
		}
		
		override protected function fInit(): void {
			_iChronolgicalPosition = _oVO.chronologicalPosition;
			this.y = 0;
			_nXAxis = _oVO.xAxisPosition;
			fDrawMask();
		}
		
		private function fDrawMask() : void {
			var t_s : Sprite  = addChild(new Sprite()) as Sprite;		
			t_s.graphics.beginFill(0x333333);
			t_s.graphics.drawRect(0, 0, _oVO.width , ApplicationFacade.APP_HEIGHT);
		}
		
	}
}
