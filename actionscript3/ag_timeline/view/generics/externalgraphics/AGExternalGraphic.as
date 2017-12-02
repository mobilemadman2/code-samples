
package net.believecollective.ag2010.view.generics.externalgraphics {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.view.generics.externalgraphics.vo.AGExternalGraphicVO;
	import net.believecollective.frameworks.pureMVC2.view.loader.CallbackLoader;
	import net.believecollective.utils.system.SysUtils;

	import flash.display.MovieClip;

	/**
	 * SPTIllustration Component
	 * 
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class AGExternalGraphic extends MovieClip {
		
		public static const NAME : String = "AGTimelineGraphic";
		
		protected var _oGraphic : CallbackLoader;

		function AGExternalGraphic(arg_AGExternalGraphicVO : AGExternalGraphicVO) {
			var t_s : String = (ApplicationFacade.IS_USING_LOCAL) ? "" : ApplicationFacade.BASEPATH + ApplicationFacade.REMOTE_TIMELINE_FILEPATH;
			var t_sBasePath:String = (arg_AGExternalGraphicVO.filename.split(".")[1] == "swf") ? t_s + ApplicationFacade.SWFPATH_COMPONENTS : t_s + ApplicationFacade.IMAGEPATH_COMPONENTS ;
			var t_sFilepath:String = 	t_sBasePath
										+ AGExternalGraphic.NAME 
										+ SysUtils.fGetPathSeparator() 
										+ arg_AGExternalGraphicVO.filename;
//			Tracer.TRACE("!!!Marianne : AGExternalGraphic.AGExternalGraphic : " + t_sFilepath);
			_oGraphic = new CallbackLoader(t_sFilepath, arg_AGExternalGraphicVO.oCBFComplete, arg_AGExternalGraphicVO.oCBFError);
			this.addChild(_oGraphic);
		}
	}
}
