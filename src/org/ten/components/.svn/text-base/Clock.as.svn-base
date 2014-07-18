package org.ten.components
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.containers.Canvas;
	import mx.controls.Label;
	import mx.effects.Rotate;
	import mx.effects.easing.*;
	
	
	public class Clock extends Canvas
	{
	   	/**
	   	 * @private
    	 * The radius from the center of the clock to the 
    	 * outer edge of the circular face outline.
    	 */
        private var clockRadius:Number;
        
        /**
         * @private
         * The x coordinate of the center of the face.
         */
        private var clockCenterX:Number;
        
        /**
         * @private
         * The y coordinate of the center of the face.
         */
        private var clockCenterY:Number;
        
        /**
         * @private
         * The canvas on which the hour hand is drawn.
         */
        private var hourHand:Canvas;
        
        /**
         * @private
         * The canvas on which the minute hand is drawn.
         */
        private var minuteHand:Canvas;
        
        /**
         * @private
         * The canvas on which the second hand is drawn.
         */
        private var secondHand:Canvas;
        
        
        /**
         * @private
         * The canvas on which the background is stored
         */
        private var background:Canvas;
        
        /**
         * @private
         * The clock's background colour.
         */ 
        private var backgroundColour:uint = 0xEEEEFF;
        
        /**
         * @private
         * The colour of the hour hand.
         */
        private var hourHandColour:uint = 0x888888;
        
        /**
         * @private
         * The colour of the minute hand.
         */
        private var minuteHandColour:uint = 0x888888;
        
        /**
         * @private
         * The colour of the second hand.
         */
        private var secondHandColour:uint = 0x888888;
        
        /**
         * Stores the time the clock is currently displaying.
         * Keep in mind that this is updated when the hands are moved.
         */
        public var currentTime:Date;
        
        /**
         * @private
         * Stores a reference to the effect used for rotation of the hands.
         */
        private var rotationEffect:Rotate;
        
        /**
         * @private
         * The timer who watches to update the time.
         */
        private var timer:Timer;
        
        /**
         * Constructor to create a clock with draggable hands.  This sets up all internal
         * measurement variables and prepares the clock to be drawn, and draws the clock.
         */ 
        public function Clock()
		{
			// call canvas's constructor
			super();
			
			// remove the scroll bars
			verticalScrollPolicy = "off";
			horizontalScrollPolicy = "off";
			
			// create a rotation effect
			rotationEffect = new Rotate();
			rotationEffect.easingFunction = Bounce.easeOut;
			rotationEffect.duration = 500;
			
			// wait for the width to be assigned, then draw
			ChangeWatcher.watch(this, "width", prepareDisplay);
        }
        
        /**
         * @private
         * When we detect a width being set, we will set everything up.
         */
        private function prepareDisplay(event:Event = null):void
        {
        	// stores the radius to the nearest pixel
			clockRadius = Math.round(this.width / 2);
			
			// we know the center is the radius (the clock is square)
			clockCenterX = clockRadius;
			clockCenterY = clockRadius;
        	
        	// draw the pieces
        	prepareClock();
        	
        	// draw the clock!
        	updateClock();
        	
        	// set up the ticker
        	if(timer == null)
        	{
	        	timer = new Timer(1000);
	        	timer.addEventListener(TimerEvent.TIMER, updateClock);
	        	timer.start();
	        }
        }
        
        /**
         * @private
         * Actually prepares the clock for time display by drawing
         * the border, labels, and hands.
         */
        private function prepareClock():void
        {
        	// draws the circular clock outline
        	background = new Canvas();
        	addChild(background);
        	drawBorder();
        	
        	// draws the hour numbers
        	drawLabels();
        	
        	// draw the tick marks
        	drawTicks();

        	// creates the three clock hands
        	createHands();
        }
		
        /**
         * @private
         * Draws the outline, the background circle, and the center circle.
         */
        private function drawBorder():void
        {
        	background.graphics.clear();
        	
//        	// fill a nice circle as the background
//        	background.graphics.lineStyle(0.5, 0x999999);
//        	background.graphics.beginFill(backgroundColour);
//        	background.graphics.drawCircle(clockCenterX, clockCenterY, clockRadius - 1);
//        	background.graphics.endFill();
        }
  
  		/**
  		 * @private
  		 * Draws the labels for each hour and marks to match.
  		 */
        private function drawLabels():void
        {
        	for (var i:Number = 1; i <= 12; i++)
        	{
        		// create a text field to hold the hour number
        		var label:Label = new Label();
        		label.text = i.toString();
        		label.setStyle("textAlign", "center");
        		label.setStyle("color", 0xFF0000);
        		
        		// adjust the font size for smaller clocks
        		// and adjust the radius multiplier aswell
        		var fontSize:Number = 15;
        		var radiusMultiplier:Number = 0.85;
        		if(this.width < 100)
        		{
        			fontSize = 8;
        			radiusMultiplier = 0.78;
        		}
        		label.setStyle("fontSize", fontSize);
        		
        		// Adds the label to the clock face display list.
	        	addChild(label);
        		
        		// format the label size for centering on the clock
        		label.width = 24;
        		label.height = label.measureText(label.text).height;
        		
        		// convert our angle to radians for the sin and cos functions
        		var angleInRadians:Number = i * 30 * (Math.PI/180)
        		
        		// place the label using the sin() and cos() functions to get the x,y coordinates.
        		// the multiplier value of 0.9 puts the labels inside the outline of the clock face.
        		label.x = clockCenterX + (radiusMultiplier * clockRadius * Math.sin(angleInRadians)) - (label.width / 2) - 1;
        		label.y = clockCenterY - (radiusMultiplier * clockRadius * Math.cos(angleInRadians)) - (label.height / 2) - 1;
        	}
        }
        
        /**
         * @private
         * Draws the tick marks for each minute of the 
         * hour and a larger tick mark for multiples
         * of five.
         */ 
        private function drawTicks():void
        {
        	for (var i:Number = 1; i <= 60; i++)
        	{
        		// create a text field to hold the hour number
        		var tick:Canvas = new Canvas();
        		
        		// figure out the outer position
        		var distance:Number = 0.71 * clockRadius;
        		
        		// set drawing stuff for minute ticks versus hour ticks
        		var thickness:Number = 2;
        		var colour:uint = 0xFF00000;
        		var depth:Number = 3;
        		if(i % 5 == 0)
        		{
        			// it's an hour tick
        			thickness = 5;
        			colour = 0xFF0000
        			depth = 5;
        		}
        		
        		// adds the tick to the clock
	        	addChild(tick);
	        	
	        	// draw the tick mark
	        	tick.graphics.lineStyle(thickness, colour);
		    	tick.graphics.moveTo(0, distance);
		    	tick.graphics.lineTo(0, distance - depth);
		    	tick.graphics.lineStyle(0, backgroundColour, 0);
		    	tick.graphics.lineTo(0, 0);
		    	tick.x = clockCenterX;
		    	tick.y = clockCenterY;
		    	
		    	// rotate!
		    	tick.rotation = 180 + (i * 6);
        	}
        }
        
        /**
         * @private
         * Creates the hour and minute hands and draws and positions 
         * them on the clock.
         */
        private function createHands():void
        {
        	// draw the hour hand!
        	var hourHandShape:Canvas = new Canvas();
        	drawHand(hourHandShape, Math.round(clockRadius * 0.40), hourHandColour, 6);
        	hourHand = Canvas(addChild(hourHandShape));
        	hourHand.x = clockCenterX;
        	hourHand.y = clockCenterY;
        	
        	// draw the minute hand
          	var minuteHandShape:Canvas = new Canvas();
        	drawHand(minuteHandShape, Math.round(clockRadius * 0.62), minuteHandColour, 4);
        	minuteHand = Canvas(addChild(minuteHandShape));
         	minuteHand.x = clockCenterX;
        	minuteHand.y = clockCenterY;
	        
	        // draw the second hand
	        var secondHandShape:Canvas = new Canvas();
        	drawHand(secondHandShape, Math.round(clockRadius * 0.62), secondHandColour, 2);
        	secondHand = Canvas(addChild(secondHandShape));
         	secondHand.x = clockCenterX;
        	secondHand.y = clockCenterY;
	        
	        // fill a smaller circle for the center dot
	        var topCircle:Canvas = new Canvas()
	        addChild(topCircle);
        	topCircle.graphics.beginFill(0xFFFFFF);
        	topCircle.graphics.drawCircle(clockCenterX, clockCenterY, 2);
        	topCircle.graphics.endFill();
        }
        
        /**
         * @private
         * Draws a clock hand image on a canvas representing the hand.
         * @param hand the canvas to draw the image onto
         * @param distance the length of the hand
         * @param colour the desired colour of the hand
         * @param thickness the thickness of the hand
         */
        private function drawHand(hand:Canvas, distance:uint, colour:uint, thickness:Number):void
        {
        	with(hand.graphics)
			{
				if(thickness <= 2)
				{
					// draw a straight line for the second hand
					beginFill(colour);
					drawRect(0, 0, thickness, distance);
					endFill();
				}
				else
				{
					// draw a pudgy line for minute and hour hands
					beginFill(colour);
					drawCircle(0, 0, thickness / 2);
					drawRect( -thickness / 2, 0, thickness, distance);
					endFill();
					
//					lineStyle(0.3, 0x222222, 0.9, true);
//					beginFill(colour, 0.9);
//					moveTo(0, distance);
//					lineTo(thickness, 0.333 * distance);
//					lineTo(0, 0);
//					lineTo(thickness, -10);
//					lineTo(-thickness, -10);
//					lineTo(0, 0);
//					lineTo(-thickness, 0.333 * distance);
//					lineTo(0, distance);
//					endFill();
				}
			}
        }
        
        /**
         * @private
         * Moves the hands to the time inside of the passed date.  Rotation times
         * are set appropriately.
         * @param time the date containing to desired time to display
         */
        public function updateClock(event:Event = null):void 
        {
        	// update the current time
        	currentTime = new Date();
        	
        	// get the time values and make sure to round the minute up
        	var seconds:uint = currentTime.getSeconds();
	        var minutes:uint = currentTime.getMinutes();
	        var hours:uint = currentTime.getHours();
	        
	        // come back later if the display is not ready
	        if(secondHand == null || minuteHand == null || hourHand == null)
	        {
	        	//callLater(updateClock);
	        	return;
	        }
	        
	        // prepare something to store our "original" rotation
	        var originalRotation:Number;
	        
	        // rotate the minutes to the time
//	        originalRotation = secondHand.rotation + 360;
//	        trace(originalRotation);
//	        if(originalRotation < 360)
//	        {
//	        	originalRotation += 360;
//	        }
//	        rotationEffect.angleFrom = originalRotation;
//	        rotationEffect.angleTo = 180 + (seconds * 6);
//	        rotationEffect.play([secondHand]);
	        secondHand.rotation = 180 + (seconds * 6);
	        
	        // rotate the minutes to the time
//	        if(minuteHand.rotation + 360 != 180 + (minutes * 6))
//	        {
//		        rotationEffect.angleFrom = minuteHand.rotation + 360;
//		        rotationEffect.angleTo = 180 + (minutes * 6);
//		        rotationEffect.play([minuteHand]);
//		    }
		    minuteHand.rotation = 180 + (minutes * 6);
	        
//	        // rotate the hours to the time
//	        if(hourHand.rotation + 360 != 180 + (hours * 30) + (minutes * 0.5))
//	        {
//		    	rotationEffect.angleFrom = hourHand.rotation + 360;
//		        rotationEffect.angleTo = 180 + (hours * 30) + (minutes * 0.5);
//				rotationEffect.play([hourHand]);
//		   	}
			hourHand.rotation = 180 + (hours * 30) + (minutes * 0.5)
		}
	}
}