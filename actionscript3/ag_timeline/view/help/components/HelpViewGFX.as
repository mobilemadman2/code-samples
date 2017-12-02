
package net.believecollective.ag2010.view.help.components {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.patterns.proxy.ConfigProxy;
	import net.believecollective.ag2010.view.generics.buttons.AGButton;
	import net.believecollective.ag2010.view.generics.buttons.AGCloseBtn;
	import net.believecollective.ag2010.view.generics.externalgraphics.vo.AGExternalGraphicVO;
	import net.believecollective.ag2010.view.help.HelpView;
	import net.believecollective.event.ButtonEvent;
	import net.believecollective.utils.ArrayUtils;
	import net.believecollective.utils.textfields.TextUtils;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;

	/**
	 * LoaderView Component
	 * 
	 * @author Marianne (dan@believecollective.net)
	 */
	public class HelpViewGFX extends MovieClip {
				
		// Data
		private var _oConfig : ConfigProxy;	
	
		private var _mcTitle : TextField;
		
		private var _mcIntro : AGHelpAnimation;	
		private var _aIntroMinis : Array;
		private var _iCurrentMini : int;
		private var _iSequenceCounter : int;
		
		private var _mcIntroText : MovieClip;
		private var _aCaptions: Array;
		private var _mcCaption1 : TextField;
		private var _mcCaption2 : TextField;
		private var _mcCaption3 : TextField;
		private var _mcCaption4 : TextField;
		
		private var _mcClose : AGButton;
		public var _mcPanel : MovieClip;

		function HelpViewGFX(arg_oConfig : ConfigProxy) {
			_mcPanel.alpha = 0.92;
			if (ApplicationFacade.IS_FACEBOOK)
			{
				_mcPanel._mcBG.width = 351.712;
				_mcPanel._mcBG.height = 229.224;
			}
			_mcPanel.x = (ApplicationFacade.APP_WIDTH - _mcPanel.width) /2;			_mcPanel.y = (ApplicationFacade.APP_HEIGHT - _mcPanel.height) /2;
			_mcClose = _mcPanel.addChild(new AGCloseBtn) as AGCloseBtn;
			_mcClose.x = _mcPanel.width - _mcClose.width - 3.5;			_mcClose.y = 3.5;
			_mcClose.name = '_mcClose';
			_oConfig = arg_oConfig;
		}
		
		public function fInit() : void {
			_mcIntro = new AGHelpAnimation(new AGExternalGraphicVO("intro.swf", fInitLoadedAnimations)) as AGHelpAnimation;
			_mcIntro.x = 15;
			_mcIntro.y = 33;
			_mcIntroText = _mcPanel.addChild(new MovieClip()) as MovieClip;
			_mcIntroText.alpha = 0;
			_mcIntroText.x = _mcIntro.x;
			fAddIntroText();
		}
		
		private function fAddIntroText() : void {
			_aCaptions = new Array();
			var t_a : Array = _oConfig.fGetInterfaceTextVO(HelpView.NAME).theInterfaceText;
			var t_sFont : String = (ApplicationFacade.LANGUAGE == "ne") ? ApplicationFacade.FONT_GURUMAA : ApplicationFacade.FONT_AUDIMAT_REGULAR;
			_mcTitle = _mcPanel.addChild(TextUtils.ADDTEXTFIELD(10,[13,7], 16, t_sFont, 0xF26522, t_a[0].theText)) as TextField;
			
			// textfield coordinates
			var t_o1 : Array = (ApplicationFacade.IS_FACEBOOK) ? [10, (_mcPanel.height/2) - 18] : [10,_mcPanel.height - 26.4];
			var t_o2 : Array = (ApplicationFacade.IS_FACEBOOK) ? [10 + ((_mcPanel.width -27)/2), (_mcPanel.height /2) - 18] : [173,_mcPanel.height - 26.4];
			var t_o3 : Array = (ApplicationFacade.IS_FACEBOOK) ? [10, _mcPanel.height - 26.4] : [338,_mcPanel.height - 26.4];
			var t_o4: Array = (ApplicationFacade.IS_FACEBOOK) ? [10 + ((_mcPanel.width -27)/2), _mcPanel.height - 26.4] : [503,_mcPanel.height - 26.4];
			//
			
			_mcCaption1 = _mcIntroText.addChild(TextUtils.ADDTEXTFIELD(150, t_o1, 12, t_sFont, 0xFFFFFF, t_a[1].theText, true)) as TextField;
			_mcCaption2 = _mcIntroText.addChild(TextUtils.ADDTEXTFIELD(150, t_o2, 12, t_sFont, 0xFFFFFF, t_a[2].theText, true)) as TextField;
			_mcCaption3 = _mcIntroText.addChild(TextUtils.ADDTEXTFIELD(150, t_o3, 12, t_sFont, 0xFFFFFF, t_a[3].theText, true)) as TextField;
			_mcCaption4 = _mcIntroText.addChild(TextUtils.ADDTEXTFIELD(150, t_o4, 12, t_sFont, 0xFFFFFF, t_a[4].theText, true)) as TextField;
//			_mcCaption1.alpha = _mcCaption2.alpha = _mcCaption3.alpha = _mcCaption4.alpha = 0.15;
			_aCaptions.push(_mcCaption1, _mcCaption2, _mcCaption3, _mcCaption4);
			TweenMax.to(_mcIntroText, ApplicationFacade.TWEEN_DURATION, {autoAlpha: 1});
		}

		private function fInitLoadedAnimations(event : Event) : void {	
			
			_aIntroMinis = new Array();
			var t_o : MovieClip = (_mcIntro.theImage.getChildAt(0) as MovieClip).getChildAt(0) as MovieClip;
			for (var i: int =0; i< t_o.numChildren; i++){
				var t_oMini : MovieClip = t_o.getChildAt(i) as MovieClip;
				TweenMax.to(t_oMini, 0, {autoAlpha : 0.15});
				ButtonEvent.makeButton(t_oMini);
				t_oMini.mouseChildren = false;
				_aIntroMinis.push(t_oMini);
				t_oMini.addEventListener(ButtonEvent.ROLL_OVER, fMouse_over);
				t_oMini.addEventListener(ButtonEvent.ROLL_OUT, fMouse_out);
			}
		
			
			if (ApplicationFacade.IS_FACEBOOK)
			{
				_aIntroMinis[2].x = _aIntroMinis[0].x;
				_aIntroMinis[3].x = _aIntroMinis[1].x;
				_aIntroMinis[2].y = _aIntroMinis[3].y = -26;	
			}
			
			_mcPanel.addChild(_mcIntro);	
			_mcIntro.theImage.alpha = 0;
			_iCurrentMini = -1;
			_iSequenceCounter = 1;
			addEventListener(Event.ENTER_FRAME, fSequenceTimer);
			TweenMax.to(_mcIntro.mcLoader, ApplicationFacade.TWEEN_DURATION, {autoAlpha: 0});			TweenMax.to(_mcIntro.theImage, ApplicationFacade.TWEEN_DURATION, {autoAlpha: 1});
		}
		
		private function fSequenceTimer(event : Event) : void {
			_iSequenceCounter --;
			if (_iSequenceCounter == 0) {
				_iCurrentMini ++;
				fToggleMinis();
				_iSequenceCounter = 250; // 10 seconds
			}
		}

		private function fToggleMinis() : void {
			if (_iCurrentMini > _aIntroMinis.length - 1) _iCurrentMini = 0; // back to the beginning
			for (var i :int = 0; i< _aIntroMinis.length; i++){
				if (i == _iCurrentMini) {
					TweenMax.to(_aIntroMinis[i] as MovieClip, ApplicationFacade.FADE_TWEEN_DURATION, {autoAlpha : 1});//					TweenMax.to(_aCaptions[i] as TextField, ApplicationFacade.TWEEN_DURATION, {autoAlpha : 1});
				}
				else {
					TweenMax.to(_aIntroMinis[i] as MovieClip, ApplicationFacade.FADE_TWEEN_DURATION, {autoAlpha : 0.15});//					TweenMax.to(_aCaptions[i] as TextField, ApplicationFacade.TWEEN_DURATION, {autoAlpha : 0.15});
				}
			}
		}

		private function fMouse_over(e : Event) : void {
			_iCurrentMini = ArrayUtils.INDEXOF(_aIntroMinis, e.target);
			fToggleMinis();
			removeEventListener(Event.ENTER_FRAME, fSequenceTimer);
		}

		private function fMouse_out(e : Event) : void {
			_iSequenceCounter = 1;
			addEventListener(Event.ENTER_FRAME, fSequenceTimer);
		}
		
		public function fToggle(arg_b : Boolean) : void {
			var t_nAlpha : Number = (arg_b) ? 1 : 0;
			TweenMax.to(this, ApplicationFacade.FADE_TWEEN_DURATION, {autoAlpha: t_nAlpha});
			if (arg_b && _mcIntro == null) fInit();
		}
		
	}
}
