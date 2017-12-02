package net.believecollective.ag2010.view.navigator.components {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.timeline.eras.AGEraVO;
	import net.believecollective.frameworks.pureMVC2.view.buttons.BButtonBaseBase;
	import net.believecollective.utils.textfields.TextUtils;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.StyleSheet;
	import flash.text.TextField;

	/**
	 * @author Marianne
	 */
	public class AGTimelineNavButton extends BButtonBaseBase {
		public var mcButton : MovieClip;		protected var mcText : MovieClip;

		protected var _nX1 : Number;		protected var _nX2 : Number;		protected var _iChronologicalPosition : Number;

		protected var _sName : String;		protected var _sDate : String;

		protected var _nTargetX : Number;

		public function AGTimelineNavButton(arg_oVO : AGEraVO) {
			
			mouseChildren = false;
			
			this.y = -1;
			gotoAndStop(arg_oVO.eraName);
			TweenMax.to(mcButton.mcOver, 0, {autoAlpha: 0});			TweenMax.to(mcButton.mcDown, 0, {autoAlpha: 0});
			//
			_iChronologicalPosition = arg_oVO.chronologicalPosition;
			_sName = (arg_oVO.eraName.substr(0,3) == "The") ? arg_oVO.eraName.substring(4): arg_oVO.eraName;			_sDate = arg_oVO.dateText;
			
			mcText = addChild(new MovieClip()) as MovieClip;
			fAddText();
		}

		public function fAddText() : void {
			var t_oCSS :StyleSheet = new StyleSheet();
			t_oCSS.setStyle("p", {letterSpacing: 0});			var t_sFont : String = (ApplicationFacade.LANGUAGE == "ne") ? ApplicationFacade.FONT_GURUMAA : ApplicationFacade.FONT_AUDIMAT_REGULAR;
			var t_nTint : Number = (_iChronologicalPosition == 3) ? 0x453E2A : 0xFFFFFF;
			for (var i: int = _sName.length-1; i>-1; i--){
				if (_sName.charAt(i) == " ") {
					var t_s1 : String = _sName.substring(0, i);					var t_s2 : String = _sName.substring(i+1);
					_sName = t_s1 + "<font size = '8'> </font>" + t_s2;
				}
			}
			mcText.addChild(TextUtils.ADDTEXTFIELD(10, [2,0], 11, t_sFont, t_nTint, "<p>"+_sName+"</p>", false, "left", t_oCSS)) as TextField;
			mcText.addChild(TextUtils.ADDTEXTFIELD(10, [2,13], 11, t_sFont, t_nTint, "<p>"+_sDate+"</p>")) as TextField;		}

		override public function fMouseDOWN(event : MouseEvent) : void {
			super.fMouseDOWN(event);
			TweenMax.to(mcButton.mcDown, 0.1, {autoAlpha: 1});			TweenMax.to(mcText, 0.1, {autoAlpha: 0.8});
		}

		override public function fMouseUP(event : MouseEvent) : void {
			super.fMouseUP(event);
			TweenMax.to(mcButton.mcDown, 0.1, {autoAlpha: 0});
			TweenMax.to(mcText, 0.1, {autoAlpha: 1});
		}

		override public function fMouseReleaseOutside(event : MouseEvent) : void {
			fMouseUP(event);
			fMouseMOUSE_OUT(event);
		}

		override public function fMouseDragOut(event : MouseEvent) : void {
			super.fMouseDragOut(event);
		}

		override public function fMouseCLICK(event : MouseEvent) : void {
			super.fMouseCLICK(event);
		}

		override public function fMouseMOUSE_OUT(event : MouseEvent) : void {
			super.fMouseMOUSE_OUT(event);
			TweenMax.to(mcButton.mcOver, 0.1, {autoAlpha: 0});
			if (_iChronologicalPosition == 3) TweenMax.to(mcText, 0.1, {tint: 0x453E2A});
		}

		override public function fMouseMOUSE_OVER(event : MouseEvent) : void {
			super.fMouseMOUSE_OVER(event);
			TweenMax.to(mcButton.mcOver, 0.1, {autoAlpha: 1});
			if (_iChronologicalPosition == 3) TweenMax.to(mcText, 0.1, {tint: 0x8A763B});
		}

		
		////////////
		public function set x1(arg_nX1 : Number) : void {
			_nX1 = arg_nX1;
		}

		public function set x2(arg_nX2 : Number) : void {
			_nX2 = arg_nX2;
		}

		public function get x1() : Number {
			return _nX1;
		}

		public function get x2() : Number {
			return _nX2;
		}

		override public function set x(arg_n : Number) : void {
			super.x = arg_n;
			_nTargetX = arg_n;
		}	

		public function set targetX(arg_nTargetX : Number) : void {
			_nTargetX = arg_nTargetX;
			TweenMax.to(this, ApplicationFacade.TWEEN_DURATION, {x: _nTargetX});
		}

		public function get targetX() : Number {
			return _nTargetX;
		}

		public function get chronologicalPosition() : Number {
			return _iChronologicalPosition;
		}
		
		public function get theDate() : String
		{
			return _sDate;
		}
	}
}
