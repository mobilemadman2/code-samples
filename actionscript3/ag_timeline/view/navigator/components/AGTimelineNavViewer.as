package net.believecollective.ag2010.view.navigator.components {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.event.ButtonEvent;
	import net.believecollective.frameworks.pureMVC2.view.buttons.BButtonBaseBase;

	import com.greensock.TweenMax;

	import flash.display.JointStyle;
	import flash.display.Sprite;

	/**
	 * @author Marianne
	 */
	public class AGTimelineNavViewer extends BButtonBaseBase {
		
		public var mcFrame: Sprite;		public var mcWindow: Sprite;		
		private var _nWidth: Number;
		private var _nTargetX : Number;
		
		public function AGTimelineNavViewer() {
			ButtonEvent.makeButton(this);
			mcFrame = addChild(new Sprite) as Sprite;
		}

		public function set theWidth(nWidth : Number) : void {
			_nWidth = nWidth;
			mcWindow.width = _nWidth;
			//mcFrame.width = _nWidth +1;
			mcFrame.graphics.clear();
			mcFrame.graphics.lineStyle(2.5, 0xFBBB03,1,false,"normal",null,JointStyle.ROUND);
			mcFrame.graphics.drawRect(mcWindow.x-1.25, mcWindow.y-1.25, mcWindow.width+2.25, mcWindow.height+1.5);
			mcFrame.graphics.beginFill(0xFFFFFF, 0);
			mcFrame.graphics.lineStyle(1, 0x322301,1,false,"normal",null,JointStyle.ROUND);
			mcFrame.graphics.drawRect(mcWindow.x+0.25, mcWindow.y+0.25, mcWindow.width-0.5, mcWindow.height-1.5);
		}

		public function set targetX (arg_nX : Number ) : void {
			_nTargetX = arg_nX;
			TweenMax.to(this, ApplicationFacade.TWEEN_DURATION, {x: _nTargetX});
		}
		
		public function get targetX() : Number {
			return _nTargetX;
		}
		
		public function get theWidth() : Number {
			return _nWidth;
		}
		
		override public function set x (arg_n : Number) : void {
			super.x = _nTargetX = arg_n;
		}
	}
}
