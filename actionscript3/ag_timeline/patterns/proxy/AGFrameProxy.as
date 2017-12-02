package net.believecollective.ag2010.patterns.proxy {
	import net.believecollective.frameworks.pureMVC2.patterns.proxy.FrameProxy;	import flash.display.MovieClip;		/**
	 * @author Dan M
	 */
	public class AGFrameProxy extends FrameProxy {
		public static const NAME : String = "AGFrameProxy";		public function AGFrameProxy(data : MovieClip) {
			super(data);
		}	}
}
