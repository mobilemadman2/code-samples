
package net.believecollective.ag2010.patterns.commands {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.patterns.proxy.TimelineProxy;

	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 * CMD_START_INTERFACE
	 */
	public class StartInterfaceCommand extends SimpleCommand implements ICommand {

		override public function execute(notification : INotification) : void {
			// initial xml is loaded >>
			var t_oTP : TimelineProxy = facade.retrieveProxy(TimelineProxy.NAME) as TimelineProxy;
			t_oTP.fSetGlobalVars(ApplicationFacade.NOTE_INIT_VIEWS);
//			(ApplicationFacadeBase.ROOT as Main).fAddCursor();
		}
	}
}
