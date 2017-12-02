package net.believecollective.ag2010.view.timeline.components.timelineelements.dividerelements {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;
	import net.believecollective.utils.textfields.TextUtils;

	import com.greensock.TweenMax;

	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author Marianne
	 */
	public class AGTimelineEraDividerText extends AGTimelineDividerBase {
		
		public static const NAME : String = "AGTimelineEraDividerText";
		
		public function AGTimelineEraDividerText(arg_oVO: AGEventVO) {
			super(arg_oVO);
		}
		
		override protected function fAddGraphics() : void {
			var t_o: Sprite = (addChild(new Sprite) as Sprite);
			t_o.graphics.beginFill(0x010101, 0.4);
			t_o.graphics.moveTo(5 , 169.767);
			t_o.graphics.lineTo(373.855 , 169.767);
			t_o.graphics.lineTo(373.855 , 239.673);
			t_o.graphics.lineTo(5 , 239.673);
			t_o.graphics.lineTo(5 , 169.767);
			////
			var t_sFont : String = (ApplicationFacade.LANGUAGE == "ne") ? ApplicationFacade.FONT_GURUMAA : ApplicationFacade.FONT_AUDIMAT_REGULAR;			var t_oText: TextField = (this.addChild(TextUtils.ADDTEXTFIELD(330, [19.908, 176.982], 15, t_sFont, 0xFFFFFF, (_oVO.eventName), true))) as TextField;
			addChild(t_oText);
			TweenMax.to(this, ApplicationFacade.TWEEN_DURATION, {autoAlpha: 1});
		}
	}
}
