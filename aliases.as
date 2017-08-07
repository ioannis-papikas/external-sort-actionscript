package {
	import flash.net.*;
	
	public class aliases {
		public function aliases() {
			//__Logos__//
			registerClassAlias("logo_greek",logo_greek);
			registerClassAlias("logo_english",logo_english);
			//__Volumes__//
			registerClassAlias("external_sort",simple_method);
			registerClassAlias("b_trees",b_trees);
			registerClassAlias("aries",aries);
			registerClassAlias("lock_management",locker);
			
			//__External Sort Methods__//
			registerClassAlias("simple_method",simple_method);
			registerClassAlias("sets_method",sets_method);
			registerClassAlias("double_method",double_method);
			registerClassAlias("merge_method",merge_method);
			registerClassAlias("comparison",comparison);
		}
		public function get_alias(txt:String) {
			var temp = getClassByAlias(txt);
			var temp2 = new temp();
			return(temp2);
		}
	}
}