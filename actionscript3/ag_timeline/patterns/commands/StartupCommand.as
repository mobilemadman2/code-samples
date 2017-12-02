
package net.believecollective.ag2010.patterns.commands {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.app.Main;
	import net.believecollective.ag2010.patterns.proxy.AGFrameProxy;
	import net.believecollective.ag2010.patterns.proxy.AGStageProxy;
	import net.believecollective.ag2010.patterns.proxy.ApplicationProxy;
	import net.believecollective.ag2010.patterns.proxy.ConfigProxy;
	import net.believecollective.ag2010.patterns.proxy.HistoryProxy;
	import net.believecollective.ag2010.patterns.proxy.LandscapeProxy;
	import net.believecollective.ag2010.patterns.proxy.TimelineProxy;
	import net.believecollective.frameworks.pureMVC2.app.ApplicationFacadeBase;
	import net.believecollective.frameworks.pureMVC2.patterns.proxy.MouseProxy;
	import net.believecollective.frameworks.pureMVC2.patterns.proxy.WebServiceProxy;
	import net.believecollective.frameworks.pureMVC2.patterns.proxy.XMLServiceProxy;
	import net.believecollective.utils.xml.XMLLoadRequest;

	import com.greensock.OverwriteManager;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.MotionBlurPlugin;
	import com.greensock.plugins.ShortRotationPlugin;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TransformAroundPointPlugin;
	import com.greensock.plugins.TweenPlugin;

	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	import flash.display.StageScaleMode;

	public class StartupCommand extends SimpleCommand implements ICommand {
		/**
		 * Register the Proxies and Mediators.
		 * 
		 * Get the View Components for the Mediators from the app,
		 * which passed a reference to itself on the notification.
		 */
		override public function execute( note : INotification ) : void {
			//Init tween manager - Set to a robust setting which overwrites immediate tweens on same objects
			OverwriteManager.init();
			TweenPlugin.activate([GlowFilterPlugin, ShortRotationPlugin, MotionBlurPlugin, TransformAroundCenterPlugin, TransformAroundPointPlugin, AutoAlphaPlugin]);
			var t_oRoot : Main = (note.getBody() as Main);
			//Config proxy
			facade.registerProxy(new ConfigProxy());
			//Timeline proxy
			facade.registerProxy(new TimelineProxy());
			//Landscape proxy
			facade.registerProxy(new LandscapeProxy());
			//History proxy
			facade.registerProxy(new HistoryProxy());
			//Web services proxy
			facade.registerProxy(new WebServiceProxy());
			//XML services proxy
			facade.registerProxy(new XMLServiceProxy());
			//Pass Stage from main root AS doc to Srage proxy
			var t_sScaleMode : String = (ApplicationFacade.IS_FACEBOOK) ? StageScaleMode.NO_SCALE : StageScaleMode.SHOW_ALL;			facade.registerProxy(new AGStageProxy(t_oRoot.stage, false, t_sScaleMode));
			//Mouse proxy
			facade.registerProxy(new MouseProxy(t_oRoot));
			//Frame proxy
			facade.registerProxy(new AGFrameProxy(t_oRoot));
			//App proxy
			facade.registerProxy(new ApplicationProxy());
			//Load Config XML
			var t_s : String = (ApplicationFacade.IS_USING_LOCAL) ? "" : ApplicationFacade.BASEPATH + ApplicationFacade.REMOTE_TIMELINE_FILEPATH;
			sendNotification	(
									ApplicationFacadeBase.CMD_LOAD_XML, 
									new XMLLoadRequest	(
															t_s + ApplicationFacade.XMLPATH + ApplicationFacade.CONFIG_XML_LOCAL_FILENAME, 
															ApplicationFacadeBase.CMD_XML_CONFIG_PARSE
														));
		}
		
	}
}