package GenArts {
	public class ImageCapturer() {
		public function ImageCapturer() {
		}
		public function capture_image(var mc:MovieClip, x1:Number, y1:Number, w1:Number, h1:Number) {
			if (x1 == undefined) x1=0;
			if (y1 == undefined) y1=0;
			if (h1 == undefined) h1=mc.height;
			if (w1 == undefined) w1=mc.width;
			trace("height = "+h1);
			trace("width = "+w1);
			var bmp:BitmapData = new BitmapData(w1, h1, true);
			var mymatrix = new Matrix();
        	mymatrix.translate(-x1, -y1)
        	bmp.draw(mc, mymatrix, new ColorTransform(), 1, new Rectangle(0, 0, w1, h1));
			for (var i=x1; i<h1; i++) {
				for (var j=y1; j<w1; j++) {
				}
			}
		}
	}
}