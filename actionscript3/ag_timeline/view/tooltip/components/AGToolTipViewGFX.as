
package net.believecollective.ag2010.view.tooltip.components {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.AGTooltipVO;
	import net.believecollective.utils.textfields.TextUtils;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author Dan M - dan@believecollective.net
	 */
	public class AGToolTipViewGFX extends MovieClip {

		private var _oVO : AGTooltipVO;
		public var _mcBG : MovieClip;		private var txt : TextField;
		private var _sText: String;
		
		protected var BUTTONBUFFER : Number = 7;
		protected var TEXTXFIX : Number = 2;
		protected var _nXOffSet : Number;
		protected var _nYOffSet : Number;
		protected var _bAbove : Boolean;
		protected var _bLeft : Boolean;
		
		public function AGToolTipViewGFX() {
			super();
			_sText = "";
			fToggleToolTip();
		}
		
		private function fAddTextField() : void {
			var t_sFont : String = (ApplicationFacade.LANGUAGE == "ne") ? ApplicationFacade.FONT_GURUMAA : ApplicationFacade.FONT_AUDIMAT_REGULAR;
			var t_sAlign : String = (_oVO.position == "left") ? TextFieldAutoSize.RIGHT : TextFieldAutoSize.LEFT;
			txt = this.addChild(TextUtils.ADDTEXTFIELD(10, [0,0], 14, t_sFont, 0xFFFFFF, _oVO.theText, false, t_sAlign)) as TextField;
			txt.selectable = false;
		}

		public function fToggleToolTip (arg_o : AGTooltipVO = null, arg_bImmediate:Boolean = false) : void {
			if (arg_o == null){
				var t_nDur:Number = (arg_bImmediate) ? 0 : 0.15;
				TweenMax.to(this, t_nDur, {autoAlpha:0});
			}else {
				_oVO = arg_o;
				if (txt) {
					if (_sText != _oVO.theText) {
						removeChild(txt);
						_sText = _oVO.theText;
						fAddTextField();
					}
				}
				else fAddTextField();
				_mcBG.bg.visible = _oVO.hasBG;
				_mcBG.bg.width = txt.width +6;
				_mcBG.bg.height = txt.height;
				_mcBG.bg.height +=3;
				fPositionBG();
				txt.y = _mcBG.bg.y + 1 + (_mcBG.bg.height /-2);				txt.x = _mcBG.bg.x + 2 + (_mcBG.bg.width /-2);
				this.x = _oVO.point.x;
				this.y = _oVO.point.y;
				TweenMax.to(this, t_nDur, {autoAlpha:1});
			}
		}

		private function fPositionBG() : void {
			switch(_oVO.position){
				case "left" :
					_mcBG.arrow.rotation = 180;
					_mcBG.bg.y = 0;
					switch (_oVO.textPosition) {
						case "" :
						case "left" :
							_mcBG.bg.x = -10 -_mcBG.bg.width /2;
							break;
						case "center" :
						_mcBG.bg.x = 0;
						break;
						case "right" :
						_mcBG.bg.x = 10 +_mcBG.bg.width /2;
						break;
					}
					break;
				case "right" :
					_mcBG.arrow.rotation = 0;
					_mcBG.bg.y = 0;
					switch (_oVO.textPosition) {
						case "" :
						case "right" :
							_mcBG.bg.x = 10+ _mcBG.bg.width /2;
							break;
						case "center" :
							_mcBG.bg.x = 0;
							break;
						case "left" :
							_mcBG.bg.x = -10 -_mcBG.bg.width /2;
							break;
					}
					break;
				case "top" :
					_mcBG.arrow.rotation = -90;
					_mcBG.bg.y = -10 -_mcBG.bg.height /2;
					switch (_oVO.textPosition) {
						case "" :
						case "center" :
							_mcBG.bg.x = 0;
							break;
						case "right" :
							_mcBG.bg.x = (_mcBG.bg.width - _mcBG.arrow.width) /2;
							break;
						case "left" :
							_mcBG.bg.x = (_mcBG.arrow.width - _mcBG.bg.width) /2;
							break;
					}
					break;
				case "bottom" :
					_mcBG.arrow.rotation = 90;
					_mcBG.bg.y = 10+ _mcBG.bg.height /2;
					switch (_oVO.textPosition) {
						case "" :
						case "center" :
							_mcBG.bg.x = 0;
							break;
						case "right" :
							_mcBG.bg.x = (_mcBG.bg.width - _mcBG.arrow.width) /2;
							break;
						case "left" :
							_mcBG.bg.x =  (_mcBG.arrow.width - _mcBG.bg.width) /2;
							break;
					}
				break;
			}
		}

	}
}
