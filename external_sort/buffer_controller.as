import mx.transitions.Tween;
import mx.transitions.easing.*;
import Page_Controller;
import debugger;
import data_settings;
class buffer_controller {
	//____________________________________________________________________________________________________VARIABLES_//
	//_____________________________________________________________________________________________Class Variables_//
	private static var _places,_num_records,_total_pages,_manager,dta,pg,pg2;
	private static var _speed = 1;
	private static var step,deg;
	private static var _init_places;
	//_______________________________________________________________________________________________Constants_//
	private static var _angle:Number = 120;
	private static var total_angle:Number = 270;
	private static var _radious:Number = 70;
	private static var centerx:Number = 512;
	private static var centery:Number = 384;
	//________________________________________________________________________________________Matrixes_//
	private static var _buffer_pages = [];
	private static var _buffer = [];
	//_______________________________________________Objects pointing objects of the Main Program_//
	private static var usb, read_disk, write_disk,walle;
	//______________________________________________________________________Temporary Variables_//
	private static var k;
	private static var _dad;
	private static var _state;
	//__________________________________________________________________Interval Variables_//
	private static var rem,move_pgs,add_pgs,temp,_sort,_write_,rel,merg,_sort3;
	//___________________________________________________________________Other Variables_//
	private static var cent_buff,cent_buf1,disk_page;
	private static var box = {};
	private static var arranged = false;
	private static var arranged2 = false;
	private static var arranged4 = false;
	private static var buffer_count = 1;
	private static var small_r = 225;
	private static var big_r = 310;
	private static var current_set;
	private static var minval = -1;
	//_____________________________________________________________________________________________End of VARIABLES_//
	//
	//____________________________________________________________________________________________________FUNCTIONS_//
	public function buffer_controller(__parent, __places, __records, __total, usb1, diska, diskb, _walle) {
		//Class Constructor______________ Initialization of Variables and Objects________________________//
		_manager = __parent;
		_places = __places;
		_init_places = __places;
		_num_records = __records;
		_total_pages = __total;
		//_______//
		debugger._output_field = _manager.tv._text;
		usb = usb1;
		read_disk = diska;
		read_disk._pages = [];
		read_disk.box = [];
		write_disk = diskb;
		write_disk._pages = [];
		write_disk.box = [];
		walle = _walle;
		//_______//
		_dad = this;
		step = Infinity;
		dta = new data_settings(_manager);
		pg = new Page_Controller(__parent, _num_records);
	}
	//________________________________________________________________________________________________Buffer Places_//
	public static function add_places() {
		//Add Places to Buffer, where pages will be placed later_________________________________________//
		var initx:Number = 350;
		var inity:Number = 150;
		_places = _places*buffer_count;
		_init_places = _places;
		for (var i = 0; i<_places; i++) {
			_buffer[i] = _manager.attachMovie("place", "place"+i, i, {_x:initx, _y:inity});
		}
		init_places();
	}
	private static function init_places() {
		//Initializes the buffer places__________________________________________________________________//
		_places = _init_places;
		removeMovieClip(cent_buff);
		removeMovieClip(cent_buf1);
		var initx:Number = 350;
		var inity:Number = 150;
		var cols = 5;
		var rows = int(_places/cols);
		var extra = _places%cols;
		var itm = {};
		if (_buffer.length != _places) {
			var temp = _buffer.length;
			for (var i = _places; i>temp; i--) {
				_buffer[i-1] = _manager.attachMovie("place", "place"+(i-1), i-1, {_x:initx, _y:inity});
			}
		}
		k = 0;
		for (var i = 0; i<=rows; i++) {
			for (var j = 0; j<cols; j++) {
				itm = _buffer[k];
				_buffer[k].x1 = initx+j*81;
				_buffer[k].y1 = inity+i*77+50;
				new Tween(itm, "_x", Strong.easeInOut, itm._x, _buffer[k].x1, .5, true);
				new Tween(itm, "_y", Strong.easeInOut, itm._y, _buffer[k].y1, .5, true);
				k++;
			}
		}
		for (i=0; i<extra; i++) {
			itm = _buffer[k];
			_buffer[k].x1 = itm._x+i*80;
			_buffer[k].y1 = itm._y+rows*80+50;
			new Tween(itm, "_x", Strong.easeInOut, itm._x, _buffer[k].x1, .5, true);
			new Tween(itm, "_y", Strong.easeInOut, itm._y, _buffer[k].y1, .5, true);
			k++;
		}
	}
	private static function arrange_places() {
		arranged = true;
		arranged2 = false;
		arranged4 = false;
		removeMovieClip(cent_buf1);
		cent_buf1 = undefined;
		if (_places == _buffer.length) {
			removeMovieClip(_buffer.pop());
		} else {
			for (var i = _init_places-1; i>_buffer.length; i--) {
				_buffer[i-1] = _manager.attachMovie("place", "place"+(i-1), i, {_x:350, _y:150});
			}
		}
		removeMovieClip(cent_buff);
		cent_buff = _manager.attachMovie("place_center", "c_place"+_places,_places, {_x:centerx, _y:centery});
		var small_r = 140;
		var big_r = 220;
		var itm = {};
		if (_buffer.length<10) {
			var k = 0;
		} else {
			var k = int(_buffer.length/3);
		}
		for (var i = 0; i<k; i++) {
			itm = _buffer[i];
			_buffer[i].x1 = cent_buff._x+Math.cos((i*(360/k)*(Math.PI/180))%360)*small_r;
			_buffer[i].y1 = cent_buff._y+Math.sin((i*(360/k)*(Math.PI/180))%360)*small_r;
			new Tween(itm, "_x", Strong.easeInOut, itm._x, _buffer[i].x1, .5, true);
			new Tween(itm, "_y", Strong.easeInOut, itm._y, _buffer[i].y1, .5, true);
		}
		for (var i = k; i<_buffer.length; i++) {
			itm = _buffer[i];
			_buffer[i].x1 = cent_buff._x+Math.cos((i*(360/(_buffer.length-k))*(Math.PI/180))%360)*big_r;
			_buffer[i].y1 = cent_buff._y+Math.sin((i*(360/(_buffer.length-k))*(Math.PI/180))%360)*big_r;
			new Tween(itm, "_x", Strong.easeInOut, itm._x, _buffer[i].x1, .5, true);
			new Tween(itm, "_y", Strong.easeInOut, itm._y, _buffer[i].y1, .5, true);
		}
		__log("Buffer Data Initialized...");
	}
	private static function arrange_places1() {
		//Arranges Places according to the First Method of External Sort_________________________________//
		arranged = false;
		arranged2 = false;
		arranged4 = false;
		arrange_places();
	}
	private static function arrange_places2() {
		//Arranges Places according to the Second Method of External Sort________________________________//
		arranged = false;
		arranged2 = true;
		arranged4 = false;
		cent_buf1 = _manager.attachMovie("place_center", "c_place"+_places, _places+1, {_x:(1.5)*centerx+50, _y:(1.5)*centery-150});
	}
	private static function arrange_places3() {
		//Arranges Places according to the Third Method of External Sort________________________________//
		removeMovieClip(_buffer.pop());
		removeMovieClip(_buffer.pop());
		cent_buff = _manager.attachMovie("place_center", "c_place"+_places, _places, {_x:370, _y:400});
		cent_buf1 = _manager.attachMovie("place_center", "c_place"+(_places+1), _places+3, {_x:630, _y:400});
		current_set = pg2.new_empty_page(500, 400, (_places-2)*_num_records);
		delete current_set.onPress;
		delete current_set.onRollOut;
		delete current_set.onRollOver;
		current_set._y = 400-current_set._height/2+22.4;
		for (var i=0; i<_buffer.length; i++) {
			new Tween(_buffer[i],"_x",Strong.easeInOut,_buffer[i]._x,current_set._x,.5,true);
			new Tween(_buffer[i],"_y",Strong.easeInOut,_buffer[i]._y,current_set._y+i*(current_set._height-22.4)/_buffer.length,.5,true);
		}
	}
	private static function arrange_places4() {
		//Arranges Places according to the Fourth Method of External Sort_________________________________//
		arranged = false;
		arranged2 = false;
		arranged4 = true;
		var xcenter = 624;
		var ycenter = 380;
		removeMovieClip(cent_buf1);
		removeMovieClip(_buffer.pop());
		removeMovieClip(_buffer.pop());
		_places = _buffer.length/2;
		cent_buff = _manager.attachMovie("place_center", "c_place"+(3*_places), 2*_places+1, {_x:xcenter, _y:ycenter});
		cent_buf1 = _manager.attachMovie("place_center", "c_place"+(3*_places+1), 2*_places+2, {_x:xcenter, _y:ycenter});
		new Tween(cent_buff, "_x", Strong.easeInOut, xcenter, xcenter-40, .5, true);
		new Tween(cent_buff, "_y", Strong.easeInOut, xcenter, ycenter+40, .5, true);
		new Tween(cent_buf1, "_x", Strong.easeInOut, xcenter, xcenter+40, .5, true);
		new Tween(cent_buf1, "_y", Strong.easeInOut, xcenter, ycenter-40, .5, true);
		for (var i = 0; i<_places; i++) {
			var itm = _buffer[i];
			_buffer[i].x1 = xcenter+Math.cos(((i*310/_places)*(Math.PI/180))%360)*small_r;
			_buffer[i].y1 = ycenter+Math.sin(((i*310/_places)*(Math.PI/180))%360)*small_r;
			new Tween(itm, "_x", Strong.easeInOut, itm._x, _buffer[i].x1, .5, true);
			new Tween(itm, "_y", Strong.easeInOut, itm._y, _buffer[i].y1, .5, true);
			//
			itm = _buffer[_places+i];
			_buffer[_places+i].x1 = xcenter+Math.cos(((i*310/_places)*(Math.PI/180))%360)*big_r;
			_buffer[_places+i].y1 = ycenter+Math.sin(((i*310/_places)*(Math.PI/180))%360)*big_r;
			new Tween(itm, "_x", Strong.easeInOut, itm._x, _buffer[_places+i].x1, .5, true);
			new Tween(itm, "_y", Strong.easeInOut, itm._y, _buffer[_places+i].y1, .5, true);
		}
	}
	private static function change_place(pos) {
		//Changes the buffer places in case of double buffering__________________//
		if (_buffer_pages[_places+pos] != undefined){
			var xcenter = 624;
			var ycenter = 380;
			_buffer[_places+pos].x1 = xcenter+Math.cos(((pos*310/k)*(Math.PI/180))%360)*small_r;
			_buffer[_places+pos].y1 = ycenter+Math.sin(((pos*310/k)*(Math.PI/180))%360)*small_r;
			_buffer[pos].x1 = xcenter+Math.cos(((pos*310/k)*(Math.PI/180))%360)*big_r;
			_buffer[pos].y1 = ycenter+Math.sin(((pos*310/k)*(Math.PI/180))%360)*big_r;
			var temp = _buffer[pos];
			_buffer[pos] = _buffer[_places+pos];
			_buffer[_places+pos] = temp;
			new Tween(_buffer[pos], "_x", Strong.easeInOut, _buffer[pos]._x, _buffer[pos].x1, .5, true);
			new Tween(_buffer[pos], "_y", Strong.easeInOut, _buffer[pos]._y, _buffer[pos].y1, .5, true);
			new Tween(_buffer[_places+pos], "_x", Strong.easeInOut, _buffer[_places+pos]._x, _buffer[_places+pos].x1, .5, true);
			new Tween(_buffer[_places+pos], "_y", Strong.easeInOut, _buffer[_places+pos]._y, _buffer[_places+pos].y1, .5, true);
			//
			_buffer_pages[pos] = _buffer_pages[_places+pos];
			_buffer_pages[_places+pos] = undefined;
			new Tween(_buffer_pages[pos], "_x", Strong.easeInOut, _buffer_pages[pos]._x, _buffer[pos].x1, .5, true);
			new Tween(_buffer_pages[pos], "_y", Strong.easeInOut, _buffer_pages[pos]._y, _buffer[pos].y1, .5, true);
			//
			var temp = cent_buff._page;
			cent_buff._page = undefined;
			new Tween(temp, "_x", Strong.easeInOut, temp._x, disk_page._x, .5*_speed, true);
			var tweener2 = new Tween(temp, "_y", Strong.easeInOut, temp._y, disk_page._y, .5*_speed, true);
			tweener2.onMotionFinished = function() {
				pg.add_subpage(disk_page,temp);
				add_page_to_disk(disk_page,write_disk);
				disk_page = undefined;
				move_(read_disk,false);
			};
		}
	}
	//________________________________________________________________________________________________Buffer Places_//
	private static function __log(txt) {
		if (data_settings.get_options()._log) {
			debugger._trace(txt);
		}
	}
	public function set_speed(num) {
		//Sets the speed of Animation________________________________________________________________//
		_speed = 1/num;
	}
	public function _initialize() {
		//Initializes Data and prepares for Sorting___________________________________________________//
		_initialize_disk();
		_state = dta.get_method();
		//_state = "sort3_buffer";
	}
	private function _initialize_disk() {
		__log("Initializing disk...");
		var tweener = new Tween(usb, "_y", Strong.easeInOut, 0, 220, 2*_speed, true);
		tweener.onMotionFinished = function() {
			usb.gotoAndPlay(2);
			deg = total_angle/_total_pages;
			if (_total_pages>50) {
				deg = total_angle/50;
			}
			__log("Adding Pages to disk...");
			add_pgs = setInterval(init_disk, 100*_speed);
		};
	}
	private static function init_disk() {
		//Initializes the disk, transfering pages___________________________________________________//
		step = dta.get_step();
		if (step) {
			dta.dec_step();
			var page = pg.new_page(54, 220, _num_records);
			page._xscale = page._yscale=0;
			__log("Adding Page "+read_disk._pages.length+" to disk...");
			add_page_to_disk(page,read_disk);
			if (read_disk._pages.length == _total_pages) {
				clearInterval(add_pgs);
				var tweener2 = new Tween(usb, "_y", Strong.easeInOut, usb._y, -10, 2*_speed, true);
				tweener2.onMotionFinished = function() {
					__log("Disk Initialized");
					_dad[_state].apply();
				};
			}
		}
	}
	private static function get_disk_xy(disk) {
		//Returns the coordinates for the next place in disk____________________________________//
		var itm = {};
		var i = disk._pages.length;
		itm.x1 = disk._x+Math.cos(((_angle+(i%50)*deg)*(Math.PI/180))%360)*_radious;
		itm.y1 = disk._y+Math.sin(((_angle+(i%50)*deg)*(Math.PI/180))%360)*_radious;
		return itm;
	}
	private static function add_page_to_disk(page, disk) {
		//Adds a page to disk___________________________________________________________________//
		var temp = get_disk_xy(disk);
		new Tween(page, "_xscale", Strong.easeInOut, page._xscale, 100, .3*_speed, true);
		new Tween(page, "_yscale", Strong.easeInOut, page._yscale, 100, .3*_speed, true);
		new Tween(page, "_x", Strong.easeInOut, page._x, temp.x1, .3*_speed, true);
		var tweener = new Tween(page, "_y", Strong.easeInOut, page._y, temp.y1, .3*_speed, true);
		if ((disk._pages.length%50 == 0) && (disk._pages.length>=50)) {
			var k = disk.box.length;
			var k1 = k*200+50;
			if (disk._pages.length%k1 == 0) {
				disk.box[k] = _manager.attachMovie("box_mc", "box"+k, _manager.getNextHighestDepth());
				disk.box[k]._x = disk._x-70+k*20;
				disk.box[k]._y = disk._y+160;
			}
			disk.box[disk.box.length-1]._alpha = (disk._pages.length/2)%101;
			for (var j = 0; j<50; j++) {
				var page2 = disk._pages[disk._pages.length-50+j];
				pg.move_page(page2,disk.box[disk.box.length-1]._x,disk.box[disk.box.length-1]._y,5*_speed,0,0);
			}
		}
		disk._pages.push(page);
	}
	private static function get_disk_page(disk) {
		//Pops the last page from disk__________________________________________________________//
		var page = {};
		page = disk._pages.pop();
		if (disk._pages.length%50 == 0) {
			for (var j = 0; j<50; j++) {
				var page2 = disk._pages[disk._pages.length-50+j];
				var x1 = disk._x+Math.cos(((_angle+(j%50)*deg)*(Math.PI/180))%360)*_radious;
				var y1 = disk._y+Math.sin(((_angle+(j%50)*deg)*(Math.PI/180))%360)*_radious;
				pg.move_page(page2,x1,y1,_speed,100,100);
			}
			disk.box[disk.box.length-1]._alpha = ((disk._pages.length-50)/2)%101;
			var k = disk.box.length-1;
			var k1 = k*200+50;
			if (disk._pages.length/k1 == 1) {
				removeMovieClip(disk.box.pop());
			}
		}
		return page;
	}
	private static function get_free_place() {
		//Returns the position of the first free place in buffer_________________________________//
		var place;
		for (var i = 0; i<_buffer.length; i++) {
			if (_buffer_pages[i] == undefined) {
				place = i;
				i = _buffer.length;
			}
		}
		return place;
	}
	private static function _is(num) {
		//Checks if the buffer is either full or empty_____________________________________________//
		var k = 0;
		for (var i = 0; i<_buffer.length; i++) {
			if (_buffer_pages[i] == undefined) {
				k++;
			}
		}
		if (k == num) {
			return true;
		}
		return false;
	}
	private static function move_to_buffer(disk) {
		if (disk._pages.length) {
			move_pgs = setInterval(move_, 100*_speed, disk, true);
			return false;
		} else {
			return true;
		}
	}
	private static function move_(disk, flag) {
		//Move Pages to Buffer________________________________________________________//
		step = dta.get_step();
		if (step) {
			dta.dec_step();
			var page = get_disk_page(disk);
			var k = get_free_place();
			pg.move_page(page,_buffer[k].x1,_buffer[k].y1,_speed);
			_buffer_pages[k] = page;
			if ((_is(0)) || (disk._pages.length == 0)) {
				clearInterval(move_pgs);
				if (flag) {
					_dad[_state].apply();
				}
			}
		}
	}
	private static function _full_buffer() {
		_dad[_state].apply();
	}
	private function sort1_buffer() {//First Method
		_state = "sort_pages";
		add_places();
		move_to_buffer(read_disk);
	}
	private function sort2_buffer() {//Second Method
		_state = "sort2_pages";
		buffer_count = 1;
		add_places();
		move_to_buffer(read_disk);
	}
	private function sort3_buffer() {//Third Method
		_state = "sort3_pages";
		pg2 = new Page_Controller(_manager, (_places-2)*_num_records);
		add_places();
		_dad[_state].apply();
	}
	private function sort4_buffer() {//Fourth Method
		_state = "sort_pages";
		buffer_count = 2;
		add_places();
		move_to_buffer(read_disk);
	}
	private function sort_pages() {
		_sort = setInterval(_sort_pages, 1000*_speed);
		_write_ = setInterval(write_buffer, 2000*_speed);
	}
	private static function _sort_pages() {
		clearInterval(_sort);
		for (var i = 0; i<_buffer_pages.length; i++) {
			pg.sort_page(_buffer_pages[i]);
		}
	}
	private function sort2_pages() {
		if (!arranged2) {
			arrange_places2();
		}
		_sort_pages();
		_sort = setInterval(_dad._sort2_pages, 1000*_speed);
	}
	private function _sort2_pages() {
		clearInterval(_sort);
		var page = pg.new_empty_page(cent_buf1._x, cent_buf1._y, _num_records);
		for (var i = 0; i<_buffer_pages.length; i++) {
			pg.move_page(_buffer_pages[i],cent_buf1._x,cent_buf1._y,_speed);
		}
		_sort = setInterval(_dad.__sort2, 500*_speed, page);
	}
	private function __sort2(page) {
		clearInterval(_sort);
		while (_buffer_pages.length) {
			var min = _buffer_pages[0]._subs[0][0];
			var k = 0;
			for (var i = 1; i<_buffer_pages.length; i++) {
				if (_buffer_pages[i]._subs[0][0]<min) {
					min = _buffer_pages[i]._subs[0][0];
					k = i;
				}
			}
			removeMovieClip(pg.remove_rec(_buffer_pages[k], 0));
			pg.add_rec(page,min);
			if (_buffer_pages[k]._subs[0].length == undefined) {
				removeMovieClip(_buffer_pages[k]);
				if (k == _buffer_pages.length-1) {
					_buffer_pages.pop();
				} else {
					_buffer_pages[k] = _buffer_pages.pop();
				}
			}
		}
		pg.update_page(page);
		add_page_to_disk(page,write_disk);
		var flag = move_to_buffer(read_disk);
		if (flag) {
			_state = "merge_buffer";
			rel = setInterval(reload_disk, 1000*_speed);
		}
	}
	private function sort3_pages() {
		if (read_disk._pages.length > 1) {
			arrange_places3();
			_sort3 = setInterval(__sort3,700*_speed);
		} else if (read_disk._pages.length == 1) {
			dta.set_step(false);
			__log("External Sort is finished");
		}
	}
	private static function __sort3() {
		step = dta.get_step();
		if (step) {
			dta.dec_step();
			if (cent_buff._page == undefined) {
				var page = get_disk_page(read_disk);
				cent_buff._page = page;
				if ((cent_buff._page == undefined) && (current_set._subs[0].length == undefined)) {
					clearInterval(_sort3);
					_state = "merge_buffer";
					repl(true);
				} else if (cent_buff._page == undefined) {
					repl(false);
				} else {
					new Tween(page, "_x", Strong.easeInOut, page._x, cent_buff._x, .3*_speed, true);
					var tweener = new Tween(page, "_y", Strong.easeInOut, page._y, cent_buff._y, .3*_speed, true);
					tweener.onMotionFinished = function() {
						repl(false);
					};
				}
			} else {
				repl(false);
			}
		}
	}
	private static function repl(flag) {
		if (cent_buf1._page == undefined) {
			cent_buf1._page = pg.new_empty_page(cent_buf1._x, cent_buf1._y, _num_records);
		}
		if (disk_page == undefined) {
			disk_page = pg.new_empty_page(write_disk._x-60, write_disk._y+150, _num_records);
		}
		if ((current_set._subs[0].length == (_places-2)*_num_records) || (cent_buff._page == undefined)) {
			var min = current_set._subs[0][0]-minval;
			var k = 0;
			if (min<0) {
				i = k;
				while ((min<0) && (i<current_set._subs[0].length)) {
					var min = current_set._subs[0][i]-minval;
					var k = i++;
				}
			}
			for (var i = k; i<current_set._subs[0].length; i++) {
				if ((current_set._subs[0][i]>minval) && ((current_set._subs[0][i]-minval)<min)) {
					min = current_set._subs[0][i]-minval;
					k = i;
				}
			}
			if (min>0) {
				minval += min;
				var val = pg2.remove_rec(current_set, k);
				new Tween(val, "_x", Strong.easeInOut, val._x, cent_buf1._page._x+pg.get_top().x1, .3, true);
				var tweener = new Tween(val, "_y", Strong.easeInOut, val._y, cent_buf1._page._y+pg.get_top().y1+cent_buf1._page._subs[0].length*10, .3, true);
				tweener.onMotionFinished = function() {
					removeMovieClip(val);
					pg.add_rec(cent_buf1._page,minval);
					pg.update_page(cent_buf1._page);
					if (cent_buf1._page._subs[0].length == _num_records) {
						new Tween(cent_buf1._page, "_x", Strong.easeInOut, cent_buf1._page._x, disk_page._x, .3, true);
						var tweener3 = new Tween(cent_buf1._page, "_y", Strong.easeInOut, cent_buf1._page._y, disk_page._y, .3, true);
						tweener3.onMotionFinished = function() {
							pg.add_subpage(disk_page,cent_buf1._page);
							cent_buf1._page = undefined;
						};
					}
					if (cent_buff._page != undefined) {
						var val = pg2.remove_rec(cent_buff._page, 0);
						pg2.add_rec(current_set,val.text);
						new Tween(val, "_x", Strong.easeInOut, val._x, current_set._x+pg.get_top().x1, .3, true);
						var tweener2 = new Tween(val, "_y", Strong.easeInOut, val._y, current_set._y+pg.get_top().y1+(current_set._subs[0].length-1)*10, .3, true);
						tweener2.onMotionFinished = function() {
							removeMovieClip(val);
							pg2.update_page(current_set);
							if (cent_buff._page._subs[0].length == undefined) {
								removeMovieClip(cent_buff._page);
								cent_buff._page = undefined;
							}
						};
					}
				};
			} else {
				if (cent_buf1._page._subs[0].length) {
					new Tween(cent_buf1._page, "_x", Strong.easeInOut, cent_buf1._page._x, disk_page._x, .3, true);
					var tweener3 = new Tween(cent_buf1._page, "_y", Strong.easeInOut, cent_buf1._page._y, disk_page._y, .3, true);
					tweener3.onMotionFinished = function() {
						pg.add_subpage(disk_page,cent_buf1._page);
						cent_buf1._page = undefined;
						add_page_to_disk(disk_page,write_disk);
						minval = -1;
						disk_page = undefined;
						if (flag) {
							reload_disk();
							removeMovieClip(current_set);
						}
					};
				} else {
					add_page_to_disk(disk_page,write_disk);
					minval = -1;
					disk_page = undefined;
					if (flag) {
						removeMovieClip(current_set);
						removeMovieClip(disk_page);
						reload_disk();
					}
				}
			}
		} else {
			var val = pg.remove_rec(cent_buff._page, 0);
			pg2.add_rec(current_set,val.text);
			new Tween(val, "_x", Strong.easeInOut, val._x, current_set._x+pg.get_top().x1, .3, true);
			var tweener2 = new Tween(val, "_y", Strong.easeInOut, val._y, current_set._y+pg.get_top().y1+(current_set._subs[0].length-1)*10, .3, true);
			tweener2.onMotionFinished = function() {
				removeMovieClip(val);
				pg2.update_page(current_set);
				if (cent_buff._page._subs[0].length == undefined) {
					removeMovieClip(cent_buff._page);
					cent_buff._page = undefined;
				}
			};
		}
	}
	private static function reload_disk() {
		//Transfers the pages from write_disk to read_disk_________________________________________//
		clearInterval(rel);
		_total_pages = write_disk._pages.length;
		var k = write_disk._pages.length;
		for (var i = 0; i<k; i++) {
			var page = get_disk_page(write_disk);
			add_page_to_disk(page,read_disk);
		}
		merge_buffer();
	}
	private static function write_buffer() {
		clearInterval(_write_);
		add_pgs = setInterval(_write, 100*_speed, write_disk);
	}
	private static function _write(disk) {
		//Transfers pages from buffer to disk_____________________________________//
		var page = _buffer_pages.shift();
		add_page_to_disk(page,disk);
		if (_buffer_pages.length == 0) {
			clearInterval(add_pgs);
			var flag = move_to_buffer(read_disk);
			if (flag) {
				_state = "merge_buffer";
				rel = setInterval(reload_disk, 1000*_speed);
			}
		}
	}
	private static function merge_buffer() {
		if (!arranged) {
			if (buffer_count == 1) {
				arrange_places();
			} else if (!arranged4) {
				arrange_places4();
			}
		}
		_state = "merge1_buffer";
		if (read_disk._pages.length) {
			if ((read_disk._pages.length == 1) && (!write_disk._pages.length) && (_is(_buffer.length))) {
				__log("External Sort is finished...");
				init_places();
				walle._show();
				dta.set_step(false);
				walle._talk("External Sort is finished");
			} else {
				move_to_buffer(read_disk);
			}
		} else if ((!read_disk._pages.length) && (write_disk._pages.length)) {
			removeMovieClip(cent_buff._page);
			cent_buff._page = undefined;
			if (_is(_buffer.length)) {
				reload_disk();
			} else {
				_dad[_state].apply();
			}
		}
	}
	private function merge1_buffer() {
		if (cent_buff._page == undefined) {
			cent_buff._page = undefined;
		}
		if (cent_buf1 == undefined) {
			disk_page = pg.new_empty_page(write_disk._x-60, write_disk._y+150, _num_records);
		} else {
			disk_page = pg.new_empty_page(cent_buf1._x, cent_buf1._y, _num_records);
		}
		merg = setInterval(_merge_buffer, 800*_speed);
	}
	private static function _merge_buffer() {
		step = dta.get_step();
		if (step) {
			dta.dec_step();
			if (cent_buff._page == undefined) {
				cent_buff._page = pg.new_empty_page(cent_buff._x, cent_buff._y, _num_records);
			}
			if (disk_page == undefined) {
				if (cent_buf1 == undefined) {
					disk_page = pg.new_empty_page(write_disk._x-60, write_disk._y+150, _num_records);
				} else {
					disk_page = pg.new_empty_page(cent_buf1._x, cent_buf1._y, _num_records);
				}
			}
			var min = _buffer_pages[0]._subs[0][0];
			var k = i=0;
			i++;
			var l;
			while ((min == undefined) && (i<_places)) {
				min = _buffer_pages[i]._subs[0][0];
				k = i++;
			}
			if (min != undefined) {
				for (var i = 1; i<_places; i++) {
					if (_buffer_pages[i]._subs[0][0]<min) {
						min = _buffer_pages[i]._subs[0][0];
						k = i;
					}
				}
				pg._point(_buffer_pages[k]);
				var lbl = pg.remove_rec(_buffer_pages[k], 0);
				pg.add_rec(cent_buff._page,min);
				var tweener = new Tween(lbl, "_x", Strong.easeInOut, lbl._x, cent_buff._page._x+pg.get_top().x1, .3*_speed, true);
				new Tween(lbl, "_y", Strong.easeInOut, lbl._y, cent_buff._page._y+pg.get_top().y1+(cent_buff._page._subs[0].length-1)*10, .3*_speed, true);
				tweener.onMotionFinished = function() {
					pg._unpoint(_buffer_pages[k]);
					pg.update_page(cent_buff._page);
					removeMovieClip(lbl);
					if (_buffer_pages[k]._subs[0].length == undefined) {
						removeMovieClip(_buffer_pages[k]);
						_buffer_pages[k] = undefined;
						change_place(k,disk_page);
					}
					if (_is(_buffer.length)) {
						clearInterval(merg);
						var temp = cent_buff._page;
						cent_buff._page = undefined;
						new Tween(temp, "_x", Strong.easeInOut, temp._x, disk_page._x, .5*_speed, true);
						var tweener2 = new Tween(temp, "_y", Strong.easeInOut, temp._y, disk_page._y, .5*_speed, true);
						tweener2.onMotionFinished = function() {
							pg.add_subpage(disk_page,temp);
							if (_is(_buffer.length)) {
								add_page_to_disk(disk_page,write_disk);
								merge_buffer();
							}
						};
					}
					if (cent_buff._page._subs[0].length == _num_records) {
						var temp = cent_buff._page;
						cent_buff._page = undefined;
						new Tween(temp, "_x", Strong.easeInOut, temp._x, disk_page._x, .5*_speed, true);
						var tweener2 = new Tween(temp, "_y", Strong.easeInOut, temp._y, disk_page._y, .5*_speed, true);
						tweener2.onMotionFinished = function() {
							pg.add_subpage(disk_page,temp);
							if (_is(_buffer.length)) {
								add_page_to_disk(disk_page,write_disk);
								merge_buffer();
							}
						};
					}
				};
			}
		}
	}
}