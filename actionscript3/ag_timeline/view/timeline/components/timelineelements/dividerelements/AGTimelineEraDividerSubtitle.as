package net.believecollective.ag2010.view.timeline.components.timelineelements.dividerelements {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;
	import net.believecollective.utils.textfields.TextUtils;

	import com.greensock.TweenMax;

	import flash.text.TextField;

	/**
	 * @author Marianne
	 */
	public class AGTimelineEraDividerSubtitle extends AGTimelineDividerBase {
		
		public static const NAME : String = "AGTimelineEraDividerSubtitle";
		
		public function AGTimelineEraDividerSubtitle(arg_oVO: AGEventVO) {
			super(arg_oVO);
		}
		
		override protected function fAddGraphics() : void {
			var t_sFont : String = (ApplicationFacade.LANGUAGE == "ne") ? ApplicationFacade.FONT_GURUMAA : ApplicationFacade.FONT_AUDIMAT_BOLD;
			var t_oText: TextField = (this.addChild(TextUtils.ADDTEXTFIELD(5, [-15, 60], 48, t_sFont, 0xFFFFFF, _oVO.eventName))) as TextField;			
			addChild(t_oText);
			TweenMax.to(this, ApplicationFacade.TWEEN_DURATION, {autoAlpha: 1});
		}
	}
}
