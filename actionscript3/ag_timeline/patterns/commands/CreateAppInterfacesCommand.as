
package net.believecollective.ag2010.patterns.commands {
	import net.believecollective.ag2010.app.Main;
	import net.believecollective.ag2010.model.vo.AGConfigVO;
	import net.believecollective.ag2010.patterns.mediators.ApplicationMediator;
	import net.believecollective.ag2010.patterns.mediators.ControlsViewMediator;
	import net.believecollective.ag2010.patterns.mediators.EventsDetailViewMediator;
	import net.believecollective.ag2010.patterns.mediators.FeedbackViewMediator;
	import net.believecollective.ag2010.patterns.mediators.HelpViewMediator;
	import net.believecollective.ag2010.patterns.mediators.LoaderViewMediator;
	import net.believecollective.ag2010.patterns.mediators.NavigatorViewMediator;
	import net.believecollective.ag2010.patterns.mediators.TestPanelViewMediator;
	import net.believecollective.ag2010.patterns.mediators.TimelineViewMediator;
	import net.believecollective.ag2010.patterns.mediators.ToolTipViewMediator;
	import net.believecollective.ag2010.patterns.proxy.ConfigProxy;
	import net.believecollective.ag2010.view.controls.ControlsView;
	import net.believecollective.ag2010.view.eventsdetail.EventsDetailView;
	import net.believecollective.ag2010.view.feedback.FeedbackView;
	import net.believecollective.ag2010.view.help.HelpView;
	import net.believecollective.ag2010.view.loader.LoaderView;
	import net.believecollective.ag2010.view.navigator.NavigatorView;
	import net.believecollective.ag2010.view.testpanel.TestPanelView;
	import net.believecollective.ag2010.view.timeline.TimelineView;
	import net.believecollective.ag2010.view.tooltip.AGToolTipView;
	import net.believecollective.frameworks.pureMVC2.app.ApplicationFacadeBase;
	import net.believecollective.model.vo.ViewCreationObjectVO;

	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class CreateAppInterfacesCommand extends SimpleCommand implements ICommand {

		override public function execute(notification : INotification) : void {
			
			facade.registerMediator(new ApplicationMediator(ApplicationFacadeBase.ROOT as Main));
			
			var t_oConfig:AGConfigVO = (facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy).config;
			
			//Create timeline screen
			sendNotification(ApplicationFacadeBase.CMD_CREATE_VIEW_AND_MEDIATOR, new ViewCreationObjectVO(ApplicationMediator.NAME, TimelineView.NAME, TimelineViewMediator.NAME));
			
			//Create navigator screen
			sendNotification(ApplicationFacadeBase.CMD_CREATE_VIEW_AND_MEDIATOR, new ViewCreationObjectVO(ApplicationMediator.NAME, NavigatorView.NAME, NavigatorViewMediator.NAME));
			
			//Create Feedback screen - TODO: Style and develop for AG
//			sendNotification(ApplicationFacadeBase.CMD_CREATE_VIEW_AND_MEDIATOR, new ViewCreationObjectVO(ApplicationMediator.NAME, FeedbackView.NAME, FeedbackViewMediator.NAME));
			if (t_oConfig.testmode){
				//Create testing panel if in test mode
				sendNotification(ApplicationFacadeBase.CMD_CREATE_VIEW_AND_MEDIATOR, new ViewCreationObjectVO(ApplicationMediator.NAME, TestPanelView.NAME, TestPanelViewMediator.NAME));
			}
				
			// loader
			sendNotification(ApplicationFacadeBase.CMD_CREATE_VIEW_AND_MEDIATOR, new ViewCreationObjectVO(ApplicationMediator.NAME, LoaderView.NAME, LoaderViewMediator.NAME));
			
			// controls 
			sendNotification(ApplicationFacadeBase.CMD_CREATE_VIEW_AND_MEDIATOR, new ViewCreationObjectVO(ApplicationMediator.NAME, ControlsView.NAME, ControlsViewMediator.NAME));
			
			//Create events detail window screen
			sendNotification(ApplicationFacadeBase.CMD_CREATE_VIEW_AND_MEDIATOR, new ViewCreationObjectVO(ApplicationMediator.NAME, EventsDetailView.NAME, EventsDetailViewMediator.NAME));
			
			// feedback 
			sendNotification(ApplicationFacadeBase.CMD_CREATE_VIEW_AND_MEDIATOR, new ViewCreationObjectVO(ApplicationMediator.NAME, FeedbackView.NAME, FeedbackViewMediator.NAME));
			
			// help 
			sendNotification(ApplicationFacadeBase.CMD_CREATE_VIEW_AND_MEDIATOR, new ViewCreationObjectVO(ApplicationMediator.NAME, HelpView.NAME, HelpViewMediator.NAME));
			
			// tooltip
			sendNotification(ApplicationFacadeBase.CMD_CREATE_VIEW_AND_MEDIATOR, new ViewCreationObjectVO(ApplicationMediator.NAME, AGToolTipView.NAME, ToolTipViewMediator.NAME));

			//Set invisibles - the navs handle visiblity internally
//			sendNotification(ApplicationFacadeBase.VISIBILITY_VIEW_OFF, [TestPanelViewMediator.NAME, FeedbackViewMediator.NAME]);			sendNotification(ApplicationFacadeBase.VISIBILITY_VIEW_OFF, [TestPanelViewMediator.NAME]);		}
	}
}
