
package net.believecollective.ag2010.view.controls.components {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.patterns.proxy.ConfigProxy;
	import net.believecollective.ag2010.view.controls.components.fullscreen.AGFullSceenBtn;
	import net.believecollective.ag2010.view.controls.components.help.AGHelpBtn;
	import net.believecollective.ag2010.view.controls.components.timeline.AGTimelineBtn;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;

	/**
	 * LoaderView Component
	 * 
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class ControlsViewGFX extends MovieClip {
				
		// Data
		private var _oConfig : ConfigProxy;	
		// buttons
		public var _mcFullScreen : AGFullSceenBtn; 		public var _mcHelp : AGHelpBtn; 
		public var _mcTimeline : AGTimelineBtn; 
				
		function ControlsViewGFX(arg_oConfig : ConfigProxy) {
			(ApplicationFacade.IS_FACEBOOK) ? TweenMax.to(_mcFullScreen, 0, {autoAlpha :0}): TweenMax.to(_mcTimeline, 0, {autoAlpha :0});
			
			_mcFullScreen.x = 2.5 + (_mcFullScreen.width/2);			_mcHelp.x = ApplicationFacade.APP_WIDTH - (_mcHelp.width/2) - 2.5;
			_mcTimeline.x = ApplicationFacade.APP_WIDTH - (_mcTimeline.width/2) - ApplicationFacade.NAV_X_BUFFER_FB -2;
			_oConfig = arg_oConfig;
		}
		
		public function fToggleButtons(arg_b : Boolean) : void {
			_mcFullScreen.fToggle(arg_b);			_mcHelp.fToggle(arg_b);
		}
	}
}