# TextKit LineNumbers

This sample code demonstrates one way of displaying line numbers in an iOS7 UITextView.  This makes use of iOS7's Text Kit classes and can accommodate texts with varying fonts from one paragraph to another.

The meat of the work takes place in the LineNumbersLayoutManager class (a subclass of NSLayoutManager).

![Screenshot](https://github.com/alldritt/TextKit_LineNumbers/blob/master/Screenshot.png?raw=true)

This version has both an Objective-C and a Swift example.

## Performance

I notice on my iPad 3 that there is a noticeable stuttering when scrolling the text downward the first time.  I've spent some time profiling the code, and these delays seems to be happening within TextKit.  My range-to-paragraph number calculation could be faster, but does not appear to be the most significant CPU user.

If your application provides an efficient means of mapping character ranges to paragraph numbers, you can replace the -[LineNumbersLayoutManager __paraNumberForRange:] method with your own code.

## To Dos

1. The line number gutter width is fixed.  It should probably expand as the total number of lines being displayed increases.  Alternatively, the font size used to draw the line numbers could be reduced to make the line number text fit in the gutter space.

2. The line number text is centered vertically within the line fragments rect.  I would like to align the line number text to the line fragment text's baseline, but I have not found a convenient way to determine this from the NSLayoutManager.

3. Find a better way of drawing the line number gutter background.  Overriding UITextView's drawRect: seems like the wrong approach, but I've not found a viable alternative.

## License (MIT)

Copyright (C) 2013 Mark Alldritt alldritt@latenightsw.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

**THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.**
