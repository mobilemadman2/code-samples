
package net.believecollective.ag2010.view.help {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.patterns.proxy.ConfigProxy;
	import net.believecollective.ag2010.view.AGBaseView;
	import net.believecollective.ag2010.view.help.components.HelpViewGFX;

	import com.greensock.TweenMax;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class HelpView extends AGBaseView {		public static const NAME : String = "HelpView";				public function HelpView() {
			super(NAME);		}				override public function fInit() : void {			mcGFX = fCreateGFX();		}		private function fCreateGFX() : HelpViewGFX {			var t_o : HelpViewGFX = new HelpViewGFX(_oConfig as ConfigProxy);
			TweenMax.to(t_o, 0, {autoAlpha: 0});			addChild(t_o);			return t_o;		}				override public function fUpdate(arg_o : Object = null, arg_sEvent : String = "") : void {			switch (arg_sEvent) {
				case ApplicationFacade.NOTE_TOGGLE_HELP:
					gfx.fToggle(arg_o as Boolean);
					break;
					//
				default:
					//					
			}
		}	}}
	
	
	