// Copyright © 2015 C4
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions: The above copyright
// notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

import UIKit
import C4

class WorkSpace: C4CanvasController {

    let infiniteScrollView = InfiniteScrollView() //create a new InfiniteScrollview object
    override func setup() {
        //creates CGRect from canvas frame
        //sets frame of infiniteScrollView to match canvas
        infiniteScrollView.frame = CGRect(canvas.frame)

        //add the view to the canvas
        canvas.add(infiniteScrollView)


        addVisualIndicators()
    }


    func addVisualIndicators() {
        //the max number of indicators
        let count = 20

        //the gap between indicators
        let gap = 150.0

        //initial offset because we're positioning from the center of each indicator's view
        let dx = 40.0

        //the calculated total width of the view's contentSize
        let width = Double(count + 1) * gap + dx

        //create main indicators
        for x in 0...count {
            //create a center point for the new indicator
            let point = C4Point(Double(x) * gap + dx, canvas.center.y)
            //create a new indicator
            createIndicator("\(x)", at: point)
        }

        //create additional indicators
        var x : Int = 0

        //create an offset variable
        var offset = dx

        //The total width (including the last "view" of the infiniteScrollView is based on the width + screen width
        //So, the total width and count of how many "extra" indicators to add is somewhat arbitrary
        //This is why we use a while loop

        //while the offset is less than the view's width
        while offset < Double(infiniteScrollView.frame.size.width) {
            //create a center point whose x value starts is the total width + the current offset
            let point = C4Point(width + offset, canvas.center.y)
            //create the width
            createIndicator("\(x)", at: point)
            //increase the offset for the next point
            offset += gap
            //increate x to be used as the variable for the next indicator's number
            x++
        }

        //update infiniteScrollView contentSize
        infiniteScrollView.contentSize = CGSizeMake(CGFloat(width) + infiniteScrollView.frame.size.width, 0)
    }

    func createIndicator(text: String, at point: C4Point) {
        //create a textshape
        let ts = C4TextShape(text: text)
        //center the shape
        ts.center = point
        //add it to the canvas
        infiniteScrollView.add(ts)
    }
}