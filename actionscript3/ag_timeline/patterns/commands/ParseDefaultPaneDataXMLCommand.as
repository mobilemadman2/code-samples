
package net.believecollective.ag2010.patterns.commands {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.utils.Tracer;

	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class ParseDefaultPaneDataXMLCommand extends SimpleCommand implements ICommand {

		override public function execute(notification : INotification) : void {
			var t_XML : XML = notification.getBody().xml;
			sendNotification(ApplicationFacade.NOTE_NEW_DATA_LOADED);
		}
		
	}
}
