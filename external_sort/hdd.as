package external_sort {
	import flash.display.*;
	import flash.events.*;
	
	public class hdd extends MovieClip {
		public function hdd() {
			btn_edit.addEventListener(MouseEvent.CLICK,edit_func);
		}
		public function edit_func(event:Event):void {
			data_panel.appendText("test\n");
			/*var edit = new hdd_edit();
			addChild(edit);*/
		}
	}
}