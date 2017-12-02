
package net.believecollective.ag2010.patterns.commands {
	import net.believecollective.ag2010.patterns.proxy.ApplicationProxy;

	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class ParseStartupXMLCommand extends SimpleCommand implements ICommand {

		override public function execute(notification : INotification) : void {
			var t_XML : XML = notification.getBody().xml;
			var t_sName:String = String(t_XML.name());
			switch (t_sName){
				case "specification":
					(facade.retrieveProxy(ApplicationProxy.NAME) as ApplicationProxy).fStartUpXMLParsed();
					break;
			}
		}
	}
}
