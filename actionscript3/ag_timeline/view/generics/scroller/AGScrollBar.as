package net.believecollective.ag2010.view.generics.scroller {
	import net.believecollective.ag2010.view.generics.scroller.components.AGScrollBarBG;
	import net.believecollective.ag2010.view.generics.scroller.components.AGScrollBarTrack;
	import net.believecollective.ag2010.view.generics.scroller.components.AGScrollButton;
	import net.believecollective.ag2010.view.generics.scroller.components.AGScrollerVO;
	import net.believecollective.event.ButtonEvent;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author Marianne
	 */
	public class AGScrollBar extends MovieClip {
		
		public static const NAME : String = "AGScrollBar";
		
		private var _oVO : AGScrollerVO;
		
		private var _bVertical : Boolean;
		private var _nScrollLength : Number;
		private var _nOriginalMCPosition : Number;
		private var _nMaxDisplacement : Number ;
		
		private var mcButton : AGScrollButton;		private var mcBar : Sprite;

		
		public function AGScrollBar(arg_vo : AGScrollerVO) {
			_oVO = arg_vo;
			fInit();
		}
		
		private function fInit() : void {
			this.x = _oVO.theX;			this.y = _oVO.theY;
			_bVertical = _oVO.vertical;
			_nScrollLength = _oVO.scrollLength;
			_nOriginalMCPosition = (_bVertical) ? _oVO.theMC.y : _oVO.theMC.x ;
			_nMaxDisplacement = (_bVertical) ? _oVO.theMC.height - _nScrollLength : _oVO.theMC.width - _nScrollLength;
//			fAddFrame();
			fAddScrollBar();
			fAddListeners();
		}

		private function fAddListeners() : void {
			// mouse wheel
			addEventListener(MouseEvent.MOUSE_WHEEL, fMouseWheel);
			// button drag
			mcButton.addEventListener(ButtonEvent.DRAG, fScroll);
			mcButton.addEventListener(ButtonEvent.DRAG_OVER, fScroll);
			mcButton.addEventListener(ButtonEvent.DRAG_OUT, fScroll);
			// bar click
			mcBar.addEventListener(MouseEvent.CLICK, fScrollBarClick);
		}

		private function fAddScrollBar() : void {
			mcBar = addChild(new Sprite) as Sprite;
			var t_oBG : AGScrollBarBG = mcBar.addChild(new AGScrollBarBG()) as AGScrollBarBG;
			t_oBG.height = _oVO.scrollLength;
			//scroll lines
			var t_oTrack : AGScrollBarTrack = mcBar.addChild(new AGScrollBarTrack()) as AGScrollBarTrack;
			t_oTrack.x = mcBar.width/2;			t_oTrack.y = AGScrollerVO.BUTTON_HEIGHT / 2;
			t_oTrack.height = t_oBG.height - AGScrollerVO.BUTTON_HEIGHT;
			// button
			fAddButton();
			// rotation			
			mcBar.rotation = (_bVertical) ? 0 : -90;
		}

		private function fAddButton() : void {
			mcButton = mcBar.addChild(new AGScrollButton(_nScrollLength)) as AGScrollButton;
			fSetButtonPos(_oVO.startPos);
		}


////// events and associated functions
	
		private function fMouseWheel(event: MouseEvent): void {
			fSetButtonPos(fGetButtonPos() - (event.delta/100));
		}

		private function fScrollBarClick(event: MouseEvent) : void {
			fSetButtonPos(mouseY / mcBar.height);		}

		private function fScroll(event : Event) : void {
			fMoveMC();
		}

		private function fMoveMC() : void {
			if (_bVertical) _oVO.theMC.y = _nOriginalMCPosition - (_nMaxDisplacement * fGetButtonPos());
			else _oVO.theMC.x = _nOriginalMCPosition - (_nMaxDisplacement * fGetButtonPos());
		}
		
		public function fSetButtonPos(arg_nPosition : Number) : void {
			// give a %
			if (arg_nPosition > 1) arg_nPosition =1;			if (arg_nPosition < 0) arg_nPosition =0;
			mcButton.y = (AGScrollerVO.BUTTON_HEIGHT / 2) + (arg_nPosition*(_nScrollLength - AGScrollerVO.BUTTON_HEIGHT));
			fMoveMC();
		}
		
		public function fGetButtonPos() : Number {
			// returns a %			
			var t_nPos : Number;
			t_nPos = (mcButton.y - (AGScrollerVO.BUTTON_HEIGHT / 2)) / (_nScrollLength - AGScrollerVO.BUTTON_HEIGHT);
			return t_nPos;
		}
	}
}
	