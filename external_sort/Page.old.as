package external_sort {
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.filters.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.text.*;
	
	//import debugger;
	//import data_settings;
	public class Page extends MovieClip {
		//private var _total_pages = 0;
		private var _num_records;
		private var _top = {x1:2,y1:0};
		private var _manager;
		private var _subs;
		//private var k = 5;
		//private var __parent;
		//private var dta;
		//private static var big_place;
	
		public function Page(parent1, rec_num) {
			_manager = parent1;
			_num_records = rec_num;
			//_total_pages = 0;
			//__parent = this;
			//debugger._output_field = _manager.tv._text;
			//dta = new data_settings(_manager);
			var page = {};
			/*page = */new_empty_page(0, 0, rec_num);
			_subs = [];
			var recs = get_recs();
			_subs[0] = recs;
			update_page(page);
			//return page;
		}
		public function get_top() {
			return _top;
		}
		/*public function new_page(x1, y1, num) {
			__log("Creating new page...");
			var page = {};
			page = new_empty_page(x1, y1, num);
			page._subs = [];
			var recs = get_recs();
			page._subs[0] = recs;
			update_page(page);
			return page;
		}*/
		public function new_empty_page(x1, y1, num) {
			//
			//var topx = -17.8;
			//var topy = -22.4;
			var page = new MovieClip();
			//page = _manager.createEmptyMovieClip("page"+_manager.getNextHighestDepth()+50, _manager.getNextHighestDepth()+50);
			//_total_pages++;
			page.x = x1;
			page.y = y1;
			var sqr = new Shape();
			var num = 6;
			var default_h = 60;
			var _h = (num>4 ? default_h+(num-4)*10 : default_h);
			var platos = 50;
			var corner = 10;
			with (sqr.graphics) {	
				lineStyle(2,0x000000,1,true,"normal",null,null,3);
				beginFill(0xFFFFFF);
				moveTo(0,0);
				lineTo(0,_h);
				lineTo(platos,_h);
				lineTo(platos,corner);
				lineTo(platos-corner,0);
				lineTo(0,0);
				endFill();
				moveTo(platos,corner);
				lineTo(platos-corner,corner);
				lineTo(platos-corner,0);
				moveTo(0,0);
			}
			page.addChild(sqr);
			/*page.createEmptyMovieClip("crc",page.getNextHighestDepth());
			page.crc._x = topx;
			page.crc._y = topy+_h;
			with (page.crc) {
				var c = 6.5;
				lineStyle(1,0x000000);
				beginFill(0xffffff);
				moveTo(0,-rad);
				curveTo(-c,-c,-rad,0);
				curveTo(-c,c,0,rad);
				curveTo(c,c,rad,0);
				curveTo(c,-c,0,-rad);
				endFill();
			}*/
			page._subs = [];
			/*for (var i = 0; i<num; i++) {
				var lbl = new Label();
				page["lbl"+i] = page.addChild(lbl);
				page["lbl"+i].x = _top.x1;
				page["lbl"+i].y = _top.y1+i*10;
				page["lbl"+i].width = platos-(_top.x1-topx);
			}
			page.attachMovie("Label","count",page.getNextHighestDepth(),{_x:page.crc._x-4, _y:page.crc._y-6,_width:18});*/
			for (var i = 0; i<num; i++) {
				var lbl = new TextField();
				page["lbl"+i] = page.addChild(lbl);
				page["lbl"+i].text = "label"+i;
				page["lbl"+i].selectable = false;
				page["lbl"+i].x = _top.x1;
				page["lbl"+i].y = _top.y1+i*14;//(page["lbl"+i].textHeight-2);
				page["lbl"+i].width = platos-2;
				page["lbl"+i].height = page["lbl"+i].textHeight+2;
			}
			var lbl2 = new TextField();
			page["count_lbl"] = page.addChildAt(lbl2,1);
			page["count_lbl"].text = "30";
			var txtfm = new TextFormat(null,45,0x0000FF);
			page["count_lbl"].setTextFormat(txtfm);
			page["count_lbl"].height = page.height;//["count_lbl"].textHeight+2;
			page["count_lbl"].width = page.width;//["count_lbl"].textWidth;
			//page["count_lbl"].alpha = 0.8;
			page["count_lbl"].selectable = false;
			//
			update_page(page);
			page._subs[0] = [];
			var _recs = _num_records;
			return page;
		}
		private function get_recs() {
			var records:Array = [];
			for (var i = 0; i<_num_records; i++) {
				records[i] = Math.round(Math.random()*100);
			}
			return records;
		}
		/*public function move_page(_page, x1, y1, spd, xsc, ysc) {
			var __dad = __parent;
			new Tween(_page, "x", Strong.easeInOut, _page.x, x1, .3*spd, true);
			new Tween(_page, "y", Strong.easeInOut, _page.y, y1, .3*spd, true);
			new Tween(_page, "scaleX", Strong.easeInOut, _page.scaleX, xsc, .3*spd, true);
			new Tween(_page, "scaleY", Strong.easeInOut, _page.scaleY, ysc, .3*spd, true);
		}
		public function sort_page(_page) {
			var __dad = __parent;
			var temp1 = _page._subs[0].sortOn("num", Array.RETURNINDEXEDARRAY | Array.NUMERIC);
			for (var i = 0; i<_page._subs[0].length; i++) {
				var tweener = new Tween(_page["lbl"+temp1[i]], "y", null, _page["lbl"+temp1[i]].y, _top.y1+i*10, .5, true);
			}
			var temp = _page._subs[0];
			temp.sortOn("num",Array.NUMERIC);
			for (var i = 0; i<_page._subs[0].length; i++) {
				_page._subs[0][i] = temp[i];
			}
			tweener.onMotionFinished = function() {
				__dad.update_page(_page);
			};
		}*/
		public function update_page(_page) {
			for (var i = 0; i<_num_records; i++) {
				_page["lbl"+i].x = _top.x1;
				_page["lbl"+i].y = _top.y1+i*15;
				_page["lbl"+i].text = _page._subs[0][i];
				if (_page._subs[0][i] == undefined) {
					_page["lbl"+i].text = "";
				}
			}
			/*if (_page._subs.length>9) {
				_page.count._x = _page.crc._x-8;
			} else {
				_page.count._x = _page.crc._x-4;
			}*/
			//_page.count.text = _page._subs.length;
			//_page.count._xscale = _page.count._yscale=75;
		}
		public function duplicate_page(_page, x1, y1) {
			var page = {};
			page = new_empty_page(x1, y1, _num_records);
			page._subs = [];
			page._subs = _page._subs;
			update_page(page);
			__log("Duplication page DONE!!");
			return page;
		}
		public function add_rec(_page, num) {
			if ((_page._subs[_page._subs.length-1].length == _num_records) || (_page._subs[_page._subs.length-1].length == undefined)) {
				_page._subs[_page._subs.length] = [];
			}
			_page._subs[_page._subs.length-1].push(num);
			__log("Rec added successfully...");
		}
		public function readd_rec(_page, num) {
			var tweener;
			var __dad = __parent;
			if (_page._subs[0].length == _num_records) {
				for (var i = 0; i<_page._subs[0].length; i++) {
					_page._subs[_page._subs.length-i] = _page._subs[_page._subs.length-i-1];
				}
				_page._subs[0] = [];
				_page._subs[0][0] = num;
			} else {
				for (var i = 0; i<_page._subs[0].length; i++) {
					tweener = new Tween(_page["lbl"+i], "_y", Strong.easeInOut, _page["lbl"+i]._y, _page["lbl"+i]._y+10, .5, true);
				}
				for (var i = 0; i<_page._subs[0].length; i++) {
					_page._subs[0][_page._subs[0].length-i] = _page._subs[0][_page._subs[0].length-i-1];
				}
				_page._subs[0][0] = num;
			}
			if (tweener) {
				tweener.onMotionFinished = function() {
					__dad.update_page(_page);
				};
			} else {
				update_page(_page);
			}
			__log("Rec readded to page...");
		}
		public function remove_rec(_page, pos) {
			var __dad = __parent;
			__log("Removing rec...");
			if (_page._subs[0].length) {
				var lbl = _manager.attachMovie("Label", "lbl_ext"+random(100), _manager.getNextHighestDepth(), {_x:_page._x+_top.x1, _y:_page._y+_top.y1+pos*10});
				lbl.text = _page._subs[0][pos];
				for (var i = pos+1; i<_page._subs[0].length; i++) {
					_page._subs[0][i-1] = _page._subs[0][i];
				}
				_page._subs[0].pop();
				_page["lbl"+pos].text = "";
				var _ex = new Tween(lbl, "_x", Strong.easeInOut, lbl._x, lbl._x+20, .2, true);
				if (_page._subs[0].length) {
					for (var i = pos+1; i<=_page._subs[0].length; i++) {
						var tweener = new Tween(_page["lbl"+i], "_y", Strong.easeInOut, _page["lbl"+i]._y, _page["lbl"+i]._y-10, .2, true);
					}
				} else {
					_page._subs.shift();
					_ex.onMotionFinished = function() {
						__dad.update_page(_page);
					};
				}
				tweener.onMotionFinished = function() {
					__dad.update_page(_page);
				};
				return lbl;
			}
		}
		public function add_subpage(page1, page2) {
			for (var i = 0; i<page2._subs.length; i++) {
				for (var j = 0; j<page2._subs[i].length; j++) {
					add_rec(page1,page2._subs[i][j]);
				}
			}
			update_page(page1);
			removeMovieClip(page2);
		}
		public function remove_subpage(_page) {
			if (_page._subs[_page._subs.length-1]) {
				var temp = {};
				temp = new_empty_page(_page._x, _page._y, _num_records);
				temp._subs[0] = _page._subs[_page._subs.length-1];
				_page._subs.pop();
				update_page(temp);
				update_page(_page);
				return temp;
			}
		}
		public function _point(_page) {
			var filter = new GlowFilter(0xFF0000, 1, 20, 20, 4, 1, false, false);
			var myFilters = [];
			myFilters.push(filter);
			_page.filters = myFilters;
		}
		public function _unpoint(_page) {
			_page.filters = [];
		}
		private static function over_page(_page) {
			if (!dta.get_step()) {
				var filter = new GlowFilter(0x00FFFF, 1, 20, 20, 7, 1, false, false);
				var myFilters = [];
				myFilters.push(filter);
				_page.filters = myFilters;
			}
		}
		private static function out_page(_page) {
			_page.filters = [];
		}
	}
}