package net.believecollective.ag2010.view.eventsdetail.components {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.view.generics.buttons.AGButton;
	import net.believecollective.ag2010.view.generics.buttons.AGTextLink;
	import net.believecollective.ag2010.view.generics.externalgraphics.AGThumbnail;
	import net.believecollective.ag2010.view.generics.externalgraphics.vo.AGExternalGraphicVO;
	import net.believecollective.ag2010.view.generics.scroller.AGScrollBar;
	import net.believecollective.ag2010.view.generics.scroller.components.AGScrollerVO;
	import net.believecollective.frameworks.pureMVC2.view.buttons.BButtonBaseBase;
	import net.believecollective.frameworks.pureMVC2.view.dialogue.components.DialogueViewGFX;
	import net.believecollective.frameworks.pureMVC2.view.textelements.TextElementBase;
	import net.believecollective.utils.textfields.HtmlTextField;
	import net.believecollective.utils.textfields.TextUtils;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.text.StyleSheet;

	/**
	 * @author Marianne
	 */
	public class EventsDetailViewGFX extends DialogueViewGFX{
		
		private var _aThumbnails : Array;
		
		private var _bResetComplete : Boolean;
		
		private var _sTitle : String;		private var _sContent : String;		private var _sCreditText : String;		
		private var _bFactoid : Boolean;
		private var _bPrevBtn : Boolean;
		private var _bNextBtn : Boolean;
		
		private var _mcThumb : AGThumbnail;
		private var mcIcon2 : MovieClip;
		
		private var _mcScroller : AGScrollBar;
		private var _mcScrollable : MovieClip;
		
		private var _mcHeaderTxt : HtmlTextField;		private var _mcCreditTxt : HtmlTextField;
		private var _mcTitleText : HtmlTextField;		private var _mcContentText : HtmlTextField;
		
		private var _mcReadMore2 : AGButton;		public var _mcPrev : AGButton;
		public var _mcNext : AGButton;
				
		function EventsDetailViewGFX() {
			
			_aThumbnails = new Array();
			mcConfirmButton = new AGTextLink() as AGTextLink; // readmore link
			mcConfirmButton.name = 'readmore';
			// !! important - must come before super();
			super();
			(ApplicationFacade.IS_FACEBOOK) ? mcPanel.gotoAndStop(2) : mcPanel.gotoAndStop(1);
			TweenMax.to(mcPanel, 0, {dropShadowFilter:ApplicationFacade.PANEL_DROP_OBJECT});
			
			//mcBlocker
			mcBlocker.width = mcBlocker.height = 0;
//			mcBlocker.x = - ApplicationFacade.DETAIL_PANEL_X;//			mcBlocker.y = 0;
			//mcPanel
			mcPanel.x = 0;
			mcPanel.y = 2;
			// the decorations
			mcIcon2 = mcPanel.mcIcon2; 		
			// buttons
			_mcReadMore2 = addChild(new AGReadMoreBtn()) as AGReadMoreBtn; // big button
			_mcReadMore2.name = 'readmore2';
			_mcReadMore2.y = mcPanel.y + 222;
			TweenMax.to(mcConfirmButton, 0, {autoAlpha:0}); 
			mcCancelButton.x = mcPanel.x + mcPanel.width - 60;
			mcCancelButton.y = mcPanel.y + 5.574;
			_mcNext.x = mcPanel.x + mcPanel.width - 60 - _mcNext.width;
			_mcReadMore2.x = _mcNext.x - _mcReadMore2.width - 10;
			_mcPrev.x = _mcReadMore2.x -10;			_mcPrev.y = _mcNext.y  = _mcReadMore2.y;
			// content txt
			_mcScrollable = mcPanel.addChild(new MovieClip) as MovieClip;
			_mcScrollable.addChild(mcConfirmButton);
			// content mask
			var t_oMask: Sprite = mcPanel.addChild(new Sprite()) as Sprite;
			t_oMask.graphics.beginFill(0xFFFFFF);
			t_oMask.graphics.drawRect(0, 0, ApplicationFacade.DETAIL_TEXT_WIDTH, ApplicationFacade.DETAIL_TEXT_MAX_HEIGHT);
			_mcScrollable.x = t_oMask.x = 243;
			_mcScrollable.y =  t_oMask.y = 44;
			_mcScrollable.mask = t_oMask;
			fToggle(false);
		}	
		
		public function fReset() : void {
			removeEventListener(Event.ENTER_FRAME, fResetComplete);
			// remove all text fields
			if (_mcContentText && _mcContentText.parent) _mcContentText.parent.removeChild(_mcContentText);
			if (_mcTitleText && _mcTitleText.parent) _mcTitleText.parent.removeChild(_mcTitleText);			if (_mcCreditTxt && _mcCreditTxt.parent) _mcCreditTxt.parent.removeChild(_mcCreditTxt);
			// reposition text container 
			_mcScrollable.y = 44;
			// remove the scroller if there is one
			if (_mcScroller != null) {
				mcPanel.removeChild(_mcScroller);
				_mcScroller = null;
			}
			// allow fInit()
			_bResetComplete = true;
		}

		public function fActivate(arg_sThumbName : String, arg_bFactoid : Boolean, arg_bPrev : Boolean, arg_bNext: Boolean, arg_sHeader : String, arg_sTimeline : String, arg_bOpenArticle : Boolean = false) : void {
			_bFactoid = arg_bFactoid;
			_bPrevBtn = arg_bPrev;
			_bNextBtn = arg_bNext;
			// timeline text
			if (_mcHeaderTxt && _mcHeaderTxt.parent) _mcHeaderTxt.parent.removeChild(_mcHeaderTxt);
			_mcHeaderTxt = fAddHeaderText(arg_sHeader);
			// buttons etc			
			_mcPrev.theEnabled = arg_bPrev;			_mcNext.theEnabled = arg_bNext;
			if (arg_bFactoid) {
				mcConfirmButton.y = 0;
				mcIcon.gotoAndStop(arg_sTimeline + "_fact"); // timeline emblem				mcIcon2.gotoAndStop(arg_sTimeline + "_fact"); // timeline emblem
				_mcReadMore2.theEnabled = false;
			}
			else {
				mcIcon.gotoAndStop(arg_sTimeline + "_entry"); // timeline emblem				mcIcon2.gotoAndStop(arg_sTimeline + "_entry"); // timeline emblem
				_mcReadMore2.theEnabled = mcConfirmButton.theEnabled = !arg_bOpenArticle;
				(mcConfirmButton as AGTextLink).fToggleText(arg_bOpenArticle);
			}
			
			// disable readmore if standalone swf
			if (ApplicationFacade.IS_USING_LOCAL) _mcReadMore2.theEnabled = false;
		
			
			TweenMax.to(mcConfirmButton, 0, {autoAlpha : 0}); // hide temporarily
         	// remove thumbnail if present
         	if (_mcThumb != null){	
				mcPanel.mcImage.removeChild(_mcThumb);
				_mcThumb = null;
			}
			// add the new thumbnail image
			if (_aThumbnails[ApplicationFacade.ACTIVE_ITEM_ID] != null) {
				_mcThumb = _aThumbnails[ApplicationFacade.ACTIVE_ITEM_ID];
				_mcThumb.theImage.alpha = 0;
				mcPanel.theImage.addChild(_mcThumb);
				fImageLoaded();
			}
			else {
				_mcThumb = mcPanel.mcImage.addChild(new AGThumbnail(new AGExternalGraphicVO("AGEventThumb/" + arg_sThumbName+".jpg", fImageLoaded, fError))) as AGThumbnail;
				_mcThumb.theImage.alpha = 0;
				_aThumbnails[ApplicationFacade.ACTIVE_ITEM_ID] == _mcThumb;
			}
			fToggle(true);
		}

		private function fError(e : IOErrorEvent) : void {
			_mcThumb.fError(); // removes event listener
			dispatchEvent(e);
		}

		private function fResetComplete(event : Event) : void {
			if (_bResetComplete) {
				_bResetComplete = false;
				fAddContent();
				removeEventListener(Event.ENTER_FRAME, fResetComplete);
			}
		}

		override public function fInit	(
									arg_sTitle : String = "", 
									arg_sContent : String = "", 
									arg_sCreditText : String = "", 
									arg_sUnused1 : String = "",
									arg_sUnused2 :String = ""
								) : void {
			_sTitle = arg_sTitle;
			_sContent = arg_sContent;
			_sCreditText = arg_sCreditText;
			////
			if (!_bResetComplete) {
				addEventListener(Event.ENTER_FRAME, fResetComplete);
				return;
			}
			else fAddContent();
		}

		private function fAddContent() : void {
			_bResetComplete = false;
			// title text
			_mcTitleText = fAddTitleText(_sTitle);
			 // credit txt
			_mcCreditTxt = fAddCreditTextField(_sCreditText);
			_mcCreditTxt.y = (ApplicationFacade.IS_FACEBOOK) ? 222 : 234 - (_mcCreditTxt.height/2);
			// content text
			_mcContentText = fAddContentText(_sContent);
			_mcContentText.y = _mcTitleText.height +5;
			if (!_bFactoid && !ApplicationFacade.IS_USING_LOCAL) {
				TweenMax.to(mcConfirmButton, 0, {autoAlpha : 1});
				mcConfirmButton.y = _mcContentText.height + _mcContentText.y;
			}
			// add scrollbar if required
			if (_mcScrollable.height >  ApplicationFacade.DETAIL_TEXT_MAX_HEIGHT)
				var t_nX : Number = (ApplicationFacade.IS_FACEBOOK) ? 458 : 584;
				_mcScroller = mcPanel.addChild(new AGScrollBar(new AGScrollerVO(_mcScrollable, ApplicationFacade.DETAIL_TEXT_MAX_HEIGHT, t_nX,44))) as AGScrollBar;
			//////////////
		}

		private function fImageLoaded(e : Event = null) : void {
			TweenMax.to(_mcThumb.theImage, ApplicationFacade.FADE_TWEEN_DURATION, {autoAlpha: 1});			_mcThumb.mcLoader.alpha = 0;
		}



/////// TEXT FIELDS //////
		protected function fAddCreditTextField(arg_sCreditText : String) : HtmlTextField {
        	var t_sFont : String = (ApplicationFacade.LANGUAGE == "ne") ? ApplicationFacade.FONT_GURUMAA : ApplicationFacade.FONT_CORBEL_REGULAR;
        	var t_nWidth : Number = (ApplicationFacade.IS_FACEBOOK) ? 282 : 410;
			var t_oCSS : StyleSheet = new StyleSheet();
        	t_oCSS.setStyle("a:link", {color:'#FFFFFF'});        	t_oCSS.setStyle("a:visited", {color:'#FFFFFF'});
			t_oCSS.setStyle("a:hover", {color:'#FFE5BD'});			t_oCSS.setStyle("a:active", {color:'#FFE5BD'});			t_oCSS.setStyle(".credits", {leading:'-1.5'});
			return mcPanel.addChild((TextUtils.ADDTEXTFIELD(t_nWidth, [2,0], 11, t_sFont, 0xFFFFFF, "<span class = 'credits'>"+arg_sCreditText+"</span>", true, "left", t_oCSS))) as HtmlTextField;
		} 
		
		private function fAddContentText(arg_sContent : String) : HtmlTextField {
			var t_sFont : String = (ApplicationFacade.LANGUAGE == "ne") ? ApplicationFacade.FONT_GURUMAA : ApplicationFacade.FONT_CORBEL_REGULAR;
			var t_nWidth : Number = (ApplicationFacade.IS_FACEBOOK) ? ApplicationFacade.DETAIL_TEXT_WIDTH_FB : ApplicationFacade.DETAIL_TEXT_WIDTH;
			var t_oCSS : StyleSheet = new StyleSheet();
			t_oCSS.setStyle("a:link", {color:'#bc7d2c',fontfamily : ApplicationFacade.FONT_AUDIMAT_BOLD});
			t_oCSS.setStyle("a:visited", {color:'#bc7d2c',fontfamily : ApplicationFacade.FONT_AUDIMAT_BOLD});
			t_oCSS.setStyle("a:hover", {color:'#E2A85E',fontfamily : ApplicationFacade.FONT_AUDIMAT_BOLD});
			t_oCSS.setStyle("a:active", {color:'#E2A85E',fontfamily : ApplicationFacade.FONT_AUDIMAT_BOLD});
			t_oCSS.setStyle(".quote", {marginLeft:'20', marginRight:'20'});
			t_oCSS.setStyle(".h2", {fontSize:'17'});
			return _mcScrollable.addChild((TextUtils.ADDTEXTFIELD(t_nWidth, [0,28], 14, t_sFont, 0x000000, arg_sContent, true, "left", t_oCSS))) as HtmlTextField;
		}
		
		private function fAddTitleText(arg_sEntryTitle: String) : HtmlTextField {
			var t_sFont : String = (ApplicationFacade.LANGUAGE == "ne") ? ApplicationFacade.FONT_GURUMAA : ApplicationFacade.FONT_AUDIMAT_BOLD;
			var t_nWidth : Number = (ApplicationFacade.IS_FACEBOOK) ? ApplicationFacade.DETAIL_TEXT_WIDTH_FB : ApplicationFacade.DETAIL_TEXT_WIDTH;
			return _mcScrollable.addChild((TextUtils.ADDTEXTFIELD(t_nWidth, [0,0], 17, t_sFont, 0x000000, arg_sEntryTitle, true))) as HtmlTextField;
		}
		
		private function fAddHeaderText(arg_sTimelineName : String) : HtmlTextField {
			var t_sFont : String = (ApplicationFacade.LANGUAGE == "ne") ? ApplicationFacade.FONT_GURUMAA : ApplicationFacade.FONT_AUDIMAT_BOLD;
			return mcPanel.addChild(TextUtils.ADDTEXTFIELD(ApplicationFacade.DETAIL_TEXT_WIDTH, [7,5], 16, t_sFont, 0xFFFFFF, arg_sTimelineName, true)) as HtmlTextField;	
		}
		
//////////////////////

		override public function fToggle(arg_b:Boolean) : void {
			if (this.visible == arg_b) return;
			if (arg_b){
				this.alpha = 0;
				this.visible = true;
			}else{
				this.alpha = 1;
				this.visible = true;
				fReset();
			}
			var t_nA : Number = (arg_b) ? 1 : 0 ;
			TweenMax.to(this, 0.3, {autoAlpha:t_nA});
		}
		
		override protected function fAddMessageTextField() : TextElementBase {
           	return null;
		}
		
		public function get mcConfirmButton2() : BButtonBaseBase {
			return _mcReadMore2;
		}
	}
}
