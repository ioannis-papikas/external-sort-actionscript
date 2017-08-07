package external_sort {
import debugger;
class data_settings {
	//
	private static var _manager;
	private static var _step = Infinity;
	public static var _method;
	public static var _options;
	public static var _places;
	public static var _records;
	public static var _total;
	//
	public function data_settings(_par) {
		_manager = _par;
	}
	public static function set_options(anim,hist,interact,log) {
		_options = {_animation:anim,_history:hist,_interaction:interact,_log:log};
	}
	public function set_step(flag) {
		if (flag) {
			_step = Infinity;
		} else {
			_step = 0;
		}
	}
	public static function get_options() {
		return _options;
	}
	public static function set_method(txt) {
		_method = txt;
	}
	public function get_method() {
		return _method;
	}
	public function get_places() {
		return _places;
	}
	public function get_records() {
		return _records;
	}
	public function get_total() {
		return _total;
	}
	public static function set_places(num) {
		_places = num;
	}
	public static function set_records(num) {
		_records = num;
	}
	public static function set_total(num) {
		_total = num;
	}
	public function inc_step() {
		_step++;
	}
	public function dec_step() {
		_step--;
	}
	public function get_step() {
		return _step;
	}
}
}