package menu {
	import flash.net.*;
	
	public class aliases {
		public function aliases() {
			//__Logos__//
			registerClassAlias("logo_greek",logo_greek);
			registerClassAlias("logo_english",logo_english);
			//__Volumes__//
			
			//__External Sort Methods__//
			registerClassAlias("simple_method",simple_method);
			registerClassAlias("sets_method",sets_method);
			registerClassAlias("double_method",double_method);
			registerClassAlias("merge_method",merge_method);
			registerClassAlias("comparison",comparison);
		}
		public function get_alias(txt:String) {
			return(getClassByAlias(txt));
		}
	}
}