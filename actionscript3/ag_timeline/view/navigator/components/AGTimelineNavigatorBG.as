package net.believecollective.ag2010.view.navigator.components {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.timeline.eras.AGEraVO;
	import net.believecollective.ag2010.view.generics.externalgraphics.AGExternalGraphic;
	import net.believecollective.ag2010.view.generics.externalgraphics.vo.AGExternalGraphicVO;
	import net.believecollective.event.ButtonEvent;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;

	/**
	 * @author Marianne
	 */
	public class AGTimelineNavigatorBG extends MovieClip {
		
		private var _aChildren : Array;
		private var _oCurrentEra : AGEraVO;
				
		public function AGTimelineNavigatorBG() {
			ButtonEvent.makeButton(this);
			buttonMode = true;
			useHandCursor = true;
			mouseChildren = false;
			
			_aChildren = new Array();
			TweenMax.to(this, 0, {autoAlpha: 0});
		}

		public function fDisplayChild(arg_oVO : AGEraVO) : void {
			_oCurrentEra = arg_oVO;
			if (_aChildren[_oCurrentEra.chronologicalPosition] == null) fAddChild();
			else fLoaded();
		}

		private function fLoaded(e : Event = null) : void {
			TweenMax.to(this, ApplicationFacade.FADE_TWEEN_DURATION, {autoAlpha : 1});
			for (var i:int = 0; i< numChildren; i++){
				if (getChildAt(i) is AGTimelineNavigatorGradient) return;
				else if (getChildAt(i) != _aChildren[_oCurrentEra.chronologicalPosition]) TweenMax.to(getChildAt(i), 0, {autoAlpha : 0});
				else TweenMax.to(getChildAt(i), ApplicationFacade.FADE_TWEEN_DURATION, {autoAlpha : 1});
			}		}

		private function fAddChild() : void {
			var t_s : String = "navigatorBG/" + _oCurrentEra.eraName;
			if (ApplicationFacade.IS_FACEBOOK) t_s = t_s +"_fb";
			_aChildren[_oCurrentEra.chronologicalPosition] = this.addChildAt(new AGExternalGraphic(new AGExternalGraphicVO(t_s+".png", fLoaded, fError)),0) as AGExternalGraphic;
		}
		
		private function fError(e : IOErrorEvent) : void {
			dispatchEvent(e);
		}
		
		public function get visibleWidth() : Number {
			var t_n : Number = 1;
			for (var i:int = 0; i< numChildren; i++){
				if (getChildAt(i) is AGExternalGraphic) return getChildAt(i).width;
			}
			return t_n;
		}
	}
}
