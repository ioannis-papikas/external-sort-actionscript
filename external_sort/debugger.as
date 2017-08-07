package external_sort {
class debugger {
	public static var _output_field;
	public static var _scroller;
	public static function _trace(msg) {
			if (_output_field == undefined) {
				trace(msg);
			} else {
				_output_field.text += msg + "\n";
				//trace(msg);
			}
	}
	public static function _clear() {
		if (_output_field != undefined) {
			_output_field.text = "";
		}
	}
}
}