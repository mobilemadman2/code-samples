package net.believecollective.ag2010.view.generics.scroller.components {
	import net.believecollective.model.SimpleConfig;

	import flash.display.Sprite;

	/**
	 * @author Marianne
	 */
	public class AGScrollerVO extends SimpleConfig {
		
		private var _oMC : Sprite;
		private var _nX : Number;
		private var _nY : Number;
		private var _nScrollLength : Number;
		private var _nStartPos : Number;
		private var _bVertical : Boolean;
		
		public static const BUTTON_WIDTH : Number = 6.6;		public static const BUTTON_HEIGHT : Number = 25.301;
		
		public function AGScrollerVO(
										arg_oMC : Sprite = null,
										arg_nScrollLength : Number = 0, // dimension of scroller window in direction of scroll
										arg_nX : Number = 0, // left edge of scroller bar
										arg_nY : Number = 0, // top edge of scroller bar
										arg_bVertical : Boolean = true,
										arg_nStartPos : Number = 0 // %
										) {
		
			_oMC = arg_oMC;
			_nX = arg_nX;
			_nY = arg_nY;
			_bVertical = arg_bVertical;
			_nScrollLength = arg_nScrollLength;
			_nStartPos = arg_nStartPos;
			
			super();
		}
		
		public function get theMC() : Sprite {
			return _oMC;
		}
		
		public function get theX() : Number {
			return _nX;
		}
		
		public function get theY() : Number {
			return _nY;
		}
		
		public function get scrollLength() : Number {
			return _nScrollLength;
		}
		
		public function get startPos() : Number {
			return _nStartPos;
		}
		
		public function get vertical() : Boolean {
			return _bVertical;
		}
	}
}
