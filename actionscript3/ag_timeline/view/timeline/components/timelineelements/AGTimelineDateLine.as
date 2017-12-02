package net.believecollective.ag2010.view.timeline.components.timelineelements {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.timeline.dates.AGDatesVO;

	import flash.display.Graphics;
	import flash.display.Sprite;

	/**
	 * @author Marianne
	 */
	public class AGTimelineDateLine extends AGTimeLineElementsBase {
		
		public static const NAME : String = "AGTimelineDateLine";
		
		public function AGTimelineDateLine(arg_oVO : AGDatesVO) {
			super(arg_oVO);
		}
		
		override protected function fAddGraphics() : void {
			var t_o : Graphics = (addChild(new Sprite) as Sprite).graphics;
			t_o.beginFill(0xF5F5F5, 0.5);
			t_o.drawRect(-0.5, 0, 1, ApplicationFacade.APP_HEIGHT);
		}
	}
}
