package net.believecollective.ag2010.view.timeline.components.timelineelements {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.timeline.dates.AGDatesVO;
	import net.believecollective.utils.textfields.TextUtils;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author Marianne
	 */
	public class AGTimelineDates extends AGTimeLineElementsBase {
		
		public static const NAME : String = "AGTimelineDates";
		
		public function AGTimelineDates(arg_oVO : AGDatesVO) {
			super(arg_oVO);
		}
		
		override protected function fAddGraphics() : void {
			//text
			var t_s : String;
			if ( _iChronolgicalPosition == 0){
				t_s = (_oVO.eventName.charAt(0) == "-") ? _oVO.eventName.substring(1)+ " BCE" : _oVO.eventName + " CE";
			} else {
				t_s = _oVO.eventName;
			}
			var t_oText: TextField = (this.addChild(TextUtils.ADDTEXTFIELD(10, [3, -3], 26, ApplicationFacade.FONT_AUDIMAT_REGULAR, 0xF5F5F5, t_s, false, "left"))) as TextField;
			t_oText.alpha = 0.5;
			t_oText.selectable = false;
			// line
			var t_o : Graphics = (addChild(new Sprite) as Sprite).graphics;
			t_o.beginFill(0xF5F5F5, 0.5);
			t_o.drawRect(-0.5, 0, 1, ApplicationFacade.APP_HEIGHT);
					}
	}
}
