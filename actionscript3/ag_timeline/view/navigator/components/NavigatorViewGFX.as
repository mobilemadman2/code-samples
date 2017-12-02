
package net.believecollective.ag2010.view.navigator.components {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.timeline.eras.AGEraVO;
	import net.believecollective.ag2010.patterns.proxy.ConfigProxy;
	import net.believecollective.ag2010.patterns.proxy.TimelineProxy;

	import com.greensock.TweenMax;

	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	/**
	 * LoaderView Component
	 * 
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class NavigatorViewGFX extends MovieClip {
				
		// Data
		private var _oProxy : TimelineProxy;
		private var _oConfig : ConfigProxy;	
		private var _oEraVO : AGEraVO;
		
		private var _nEraStart: Number;
		private var _nEraWidth: Number;
		
		private var _nWidth: Number;		private var _nScrollWidth: Number;		private var _nDragMinX: Number;
		private var _nViewerPos : Number;
		private var _mcScene : AGTimelineNavigatorBG ; // BG with gradient overlay		private var _mcScene2 : AGTimelineNavigatorBG ; // BG masaked by scroller window
		
		private var _BGElements : MovieClip;
		
		// vars
		private var _aButtons: Array;		private var _mcViewer: AGTimelineNavViewer;
	
	
		function NavigatorViewGFX(arg_oConfig : ConfigProxy, arg_oTLP:TimelineProxy) {
			_oProxy = arg_oTLP;
			_oConfig = arg_oConfig;
			_nWidth = ApplicationFacade.APP_WIDTH - (2* ApplicationFacade.NAV_X_BUFFER);
			this.y = 263;
			this.x = ApplicationFacade.NAV_X_BUFFER;
			_aButtons = new Array();
			fAddBG();
		}
		
		private function fAddBG() : void {
			_BGElements = addChild(new MovieClip()) as MovieClip;
			
			//draw a rounded rect with gradient fill for the absolute background
			var t_oG : AGTimelineNavigatorGradient = _BGElements.addChild(new AGTimelineNavigatorGradient) as AGTimelineNavigatorGradient;
			t_oG.gotoAndStop(2);
			var t_oMask = (addChild(new Sprite()) as Sprite); // needs to sit below the scene mcs
			t_oMask.graphics.beginFill(0xFFFFFF);
			t_oMask.graphics.drawRoundRect(-3, -0.25, _nWidth+6, ApplicationFacade.NAV_BAR_HEIGHT+0.5, 12,12);
			t_oG.mask = t_oMask ;
			
			if (ApplicationFacade.IS_FACEBOOK) _nWidth -= 33; // fbmode has a large but on rhs for the timeline button
			
			// draw the top and bottom border
			var t_Lines : Graphics = (_BGElements.addChild(new Sprite()) as Sprite).graphics; // needs to sit above the scene mcs
			t_Lines.lineStyle(1,0x000000,0.4,false,"normal",CapsStyle.NONE);
			t_Lines.moveTo(0.5, 0.5);
			t_Lines.lineTo(_nWidth-1, 0.5);
			t_Lines.lineStyle(1,0xFFFFFF,0.4,false,"normal",CapsStyle.NONE);
			t_Lines.moveTo(0.5, ApplicationFacade.NAV_BAR_HEIGHT -0.5);			t_Lines.lineTo(_nWidth-1, ApplicationFacade.NAV_BAR_HEIGHT -0.5);
		}

		private function fResetBG(): void {
			// changes the bg image according to current era
			_mcScene.fDisplayChild(_oEraVO);			_mcScene2.fDisplayChild(_oEraVO);
			_mcScene.x = _mcScene2.x = _nDragMinX -1;
		}

		public function fInit(arg_oEraVO : AGEraVO) : void {
			// buttons
			for each (var oEra : AGEraVO in _oProxy.timeline.eras) {
				var t_oButton : AGTimelineNavButton = (ApplicationFacade.IS_FACEBOOK) ? (new AGTimelineNavButtonFB(oEra)) as AGTimelineNavButton : (new AGTimelineNavButton(oEra)) as AGTimelineNavButton;
				t_oButton.x1 = (ApplicationFacade.NAV_BUTTON_SEPARATION * oEra.chronologicalPosition);				t_oButton.x2 = _nWidth - (ApplicationFacade.NAV_BUTTON_SEPARATION * (_oProxy.timeline.eras.length - oEra.chronologicalPosition));
				t_oButton.x =  ( oEra.chronologicalPosition > ApplicationFacade.CURRENT_ERA_IN_VIEW) ? t_oButton.x2 : t_oButton.x1;
				_aButtons.push(t_oButton);
				addChild(t_oButton);
			}
			// viewer
			_mcViewer = addChild(new AGTimelineNavViewer()) as AGTimelineNavViewer;
			
			_oEraVO = arg_oEraVO;
			
			// we have 2 instances of the bg image, one sits behind a gradient screen and one is masked by the viewer window
			_mcScene = _BGElements.addChild(new AGTimelineNavigatorBG()) as AGTimelineNavigatorBG;
			var t_oG : AGTimelineNavigatorGradient = _mcScene.addChild(new AGTimelineNavigatorGradient) as AGTimelineNavigatorGradient;
			t_oG.stop();			_mcScene2 = _BGElements.addChild(new AGTimelineNavigatorBG()) as AGTimelineNavigatorBG;
			// masks
			var t_o : Sprite  = (addChild(new Sprite) as Sprite);			t_o.graphics.beginFill(0xFFFFFF);
			t_o.graphics.drawRect(0, 0, _nWidth-1, ApplicationFacade.NAV_BAR_HEIGHT) as Rectangle;			_mcScene.mask = t_o;
			_mcScene2.mask = _mcViewer.mcWindow;
			_BGElements.setChildIndex(_mcScene, 1);			_BGElements.setChildIndex(_mcScene2, 2);
			fInitScroller();
		}

		private function fInitScroller() : void {
			_nEraStart = _oEraVO.eraStartX;
			_nEraWidth = _oEraVO.pixelWidth - ApplicationFacade.APP_WIDTH;
			var t_oButton : AGTimelineNavButton = _aButtons[ApplicationFacade.CURRENT_ERA_IN_VIEW];
			_nDragMinX = (t_oButton.chronologicalPosition > ApplicationFacade.CURRENT_ERA_IN_VIEW) ? t_oButton.x2 + t_oButton.width : t_oButton.x1 + t_oButton.width;
			fResetBG(); // ! important set _nDragMin before calling fRestBG();
			_nScrollWidth = _nWidth - (_aButtons.length * ApplicationFacade.NAV_BUTTON_SEPARATION);
			_mcViewer.theWidth = _nScrollWidth / (_nEraWidth / ApplicationFacade.APP_WIDTH);
			_nScrollWidth -= _mcViewer.theWidth;
			//
			_nViewerPos = Math.abs(ApplicationFacade.CURRENT_X_IN_FOCUS - ApplicationFacade.HORIZONTAL_FOCUS_POINT - _nEraStart)/ _nEraWidth;
			if (_nViewerPos < 0) _nViewerPos = 0;
			if (_nViewerPos > 1) _nViewerPos = 1;
			_mcViewer.x = _nDragMinX + (_nViewerPos * _nScrollWidth);
			// add Ticks
			// TODO ??
			// fade in
			TweenMax.to(_mcViewer, 1, {autoAlpha: 1});
		}

		public function fShiftEras(arg_oEraVO : AGEraVO) : void {
			// move buttons//
			for each (var oButton : AGTimelineNavButton in _aButtons) {
				oButton.targetX = (oButton.chronologicalPosition > ApplicationFacade.CURRENT_ERA_IN_VIEW) ? oButton.x2 : oButton.x1;
			}
			_oEraVO = arg_oEraVO;
			_nEraStart = _oEraVO.eraStartX;
			_nEraWidth = _oEraVO.pixelWidth - ApplicationFacade.APP_WIDTH;
			var t_oButton : AGTimelineNavButton = _aButtons[ApplicationFacade.CURRENT_ERA_IN_VIEW];
			_nDragMinX = (t_oButton.chronologicalPosition > ApplicationFacade.CURRENT_ERA_IN_VIEW) ? t_oButton.x2 + t_oButton.width : t_oButton.x1 + t_oButton.width;
			// fade scroll bar & BG out			TweenMax.to(_mcViewer, ApplicationFacade.TWEEN_DURATION, {autoAlpha: 0, onComplete: fInitScroller});
			TweenMax.to(_mcScene, 0, {autoAlpha: 0});			TweenMax.to(_mcScene2, 0, {autoAlpha: 0});
		}

		public function fMoveScrollHead(arg_o : AGEraVO): void {
			if (_oEraVO != arg_o)fShiftEras(arg_o);
			_nViewerPos = Math.abs(ApplicationFacade.CURRENT_X_IN_FOCUS - ApplicationFacade.HORIZONTAL_FOCUS_POINT - _nEraStart)/ _nEraWidth;
			if (_nViewerPos < 0) _nViewerPos = 0;
			if (_nViewerPos > 1) _nViewerPos = 1;
			_mcViewer.targetX = _nDragMinX + (_nViewerPos * _nScrollWidth);		
		}

		
		public function get mcViewer() : AGTimelineNavViewer {
			return _mcViewer;
		}
		
		public function get scrollWidth() : Number {
			return _nScrollWidth;
		}
		
		public function get eraStart() : Number {
			return _nEraStart;
		}
		
		public function get eraWidth() : Number {
			return _nEraWidth;
		}
		
		public function get viewerPos() : Number {
			// returns a %
			return _nViewerPos;
		}
		
		public function get mcScene() : AGTimelineNavigatorBG {
			return _mcScene;
		}
	}
}
