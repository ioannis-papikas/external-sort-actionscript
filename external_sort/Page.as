package external_sort {
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.filters.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.text.*;
	
	public class Page extends MovieClip {
		private var _num_records;
		private var _top = {x1:2,y1:0};
		private var _manager;
		private var _subs = [];
		private var labels = [];
		private var count_lbl;
		private var sqr:Shape;
		private var rect:Shape;
		
		public function Page(parent1, rec_num) {
			_manager = parent1;
			_num_records = rec_num;
			new_empty_page(0, 0, rec_num);
			_subs[0] = get_recs();
			update_page();
		}
		public function get_top() {
			return _top;
		}
		public function new_empty_page(x1, y1, num) {
			sqr = new Shape();
			var default_h = 60;
			var _h = (num>4 ? default_h+(num-4)*15 : default_h);
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
			rect = new Shape();
			with (rect.graphics) {
				var rect_size = 20;
				lineStyle(2,0x000000,1,true,"normal",null,null,3);
				beginFill(0xFFFFFF);
				drawRect(0,0,rect_size*2,rect_size);
			}
			addChild(sqr);
			addChild(rect);
			rect.x = platos-rect.width/2;
			rect.y = _h-rect.height/2;
			//__Data Number Labels__//
			for (var i = 0; i<num; i++) {
				var lbl = new TextField();
				labels[i] = addChild(lbl);
				labels[i].text = Math.round(Math.random()*1000);
				var txtfm = new TextFormat(null,14,0x000000,true);
				labels[i].setTextFormat(txtfm);
				labels[i].selectable = false;
				labels[i].x = _top.x1;
				labels[i].y = _top.y1+i*14;
				labels[i].width = platos-2;
				labels[i].height = labels[i].textHeight+2;
			}
			//__Data Number Labels__//____End
			
			//__Subpage Number Label__//
			var temp_h = this.height;
			
			var lbl2 = new TextField();
			count_lbl = addChildAt(lbl2,2);
			count_lbl.text = "30";
			var txtfm2 = new TextFormat(null,15,0x0000FF,true,null,null,null,null,"center");
			count_lbl.setTextFormat(txtfm2);
			count_lbl.height = rect.height;
			count_lbl.width = rect.width;
			count_lbl.x = rect.x;
			count_lbl.y = rect.y;
			count_lbl.selectable = false;
			//__Subpage Number Label__//____End
			_subs[0] = [];
		}
		private function get_recs() {
			var records:Array = [];
			for (var i = 0; i<_num_records; i++) {
				records[i] = Math.round(Math.random()*100);
			}
			return records;
		}
		public function update_page() {
			for (var i = 0; i<_num_records; i++) {
				labels[i].x = _top.x1;
				labels[i].y = _top.y1+i*14;
				labels[i].text = _subs[0][i];
				if (_subs[0][i] == undefined) {
					labels[i].text = "";
				}
				var txtfm = new TextFormat(null,14,0x000000,true);
				labels[i].setTextFormat(txtfm);
			}
		}
		public function add_rec(num) {
			if ((_subs[_subs.length-1].length == _num_records) || (_subs[_subs.length-1].length == undefined)) {
				_subs[_subs.length] = [];
			}
			_subs[_subs.length-1].push(num);
		}
		public function sort_page() {
			var __dad = __parent;
			var temp1 = _subs[0].sortOn("num", Array.RETURNINDEXEDARRAY | Array.NUMERIC);
			for (var i = 0; i<_subs[0].length; i++) {
				var tweener = new Tween(labels[temp1[i]], "y", null, labels[temp1[i]].y, _top.y1+i*14, .5, true);
			}
			var temp = _subs[0];
			temp.sortOn("num",Array.NUMERIC);
			for (var i = 0; i<_subs[0].length; i++) {
				_subs[0][i] = temp[i];
			}
			tweener.onMotionFinished = function() {
				__dad.update_page(_page);
			};
		}
	}
}