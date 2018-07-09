
package net.believecollective.ag2010.view.help {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.patterns.proxy.ConfigProxy;
	import net.believecollective.ag2010.view.AGBaseView;
	import net.believecollective.ag2010.view.help.components.HelpViewGFX;

	import com.greensock.TweenMax;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class HelpView extends AGBaseView {
			super(NAME);
			TweenMax.to(t_o, 0, {autoAlpha: 0});
				case ApplicationFacade.NOTE_TOGGLE_HELP:
					gfx.fToggle(arg_o as Boolean);
					break;
					//
				default:
					//					
			}
		}
	
	
	