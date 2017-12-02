package net.believecollective.ag2010.view.timeline.components.timelineelements {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;
	import net.believecollective.utils.textfields.TextUtils;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author Marianne
	 */
	
	public class AGTimelineEventLabel extends AGTimeLineElementsBase {
		
		public static const NAME : String = "AGTimelineEventLabel";
		
		private var _mcLabel: TextField;
		public var _mcIcon : MovieClip;		public var _mcBG : Sprite;
		
		public function AGTimelineEventLabel(arg_oVO : AGEventVO) {
			super(arg_oVO);
		}
		
		override protected function fInit() : void {
			var t_nAlpha : Number;
			if (_oVO.activated && _oVO.visible) t_nAlpha = 1;
			else t_nAlpha = (_oVO.visible) ? 0.6 : 0;
			TweenMax.to (this, 0, {autoAlpha : t_nAlpha});
			super.fInit();
			theEnabled = true;
		}
	
		override protected function fAddGraphics() : void {			
			switch (ApplicationFacade.LANGUAGE){
				case "en" :
					_mcLabel = (this.addChild(TextUtils.ADDTEXTFIELD(10, [15, 0], 12, ApplicationFacade.FONT_AUDIMAT_REGULAR, 0x000000, _oVO.eventName))) as TextField;
				break;
				case "cy" :
					_mcLabel = (this.addChild(TextUtils.ADDTEXTFIELD(10, [15, 0], 12, ApplicationFacade.FONT_AUDIMAT_REGULAR, 0x000000, _oVO.eventName))) as TextField;
				break;
				case "ne" :
					_mcLabel = (this.addChild(TextUtils.ADDTEXTFIELD(10, [15, 0], 12, ApplicationFacade.FONT_GURUMAA, 0x000000, _oVO.eventName))) as TextField;
				break;
			}
			_mcLabel.y = _mcLabel.height /-2;
			// white label BG
			_mcBG.width = _mcLabel.width + 10;
			var t_s : String = (_bFactoid) ? _oVO.timelineID + "_fact" : _oVO.timelineID + "_entry";
			_mcIcon.gotoAndStop(t_s);
		}

		override public function fToggle(arg_b : Boolean): void {
			var t_nAlpha : Number = (arg_b) ? 1 : 0;
			TweenMax.to(_mcIcon, ApplicationFacade.TWEEN_DURATION, {autoAlpha : t_nAlpha});
			_bActivated = true;
		}
	}
}
