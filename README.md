# Photo-OCR-Octave

I am trying to build a Photo OCR in Octave. It will recognize the optical characters or simply text from the given photo. Photo here need not to be just text only. It can be any natural photo like a pic of a busy street.

I am not any expert programmer. I have no experience in Computer Vision or Machine Learning. This is my first project on ML and after starting it, I found that I also need basics of Computer Vision for processing the image.

I worked on the preprocessing image part, before recognising stage. 
In preprocessing, main task is to detect the text region from the whole picture. In MATLAB, MSER is very common and useful way to detect text area. But both MATLAB and Computer Vision System Toolbox(the toolbox containing MSER) are paid. So, I tried to implement them in Octave by coding required features myself, so that I can also enhance my coding skills.

I used Stroke Width Transform method to detect text from other regions. SWT, was not available anywhere in the form of Octave/Matlab code(or I was not able to get it because I am not an expert). It was available through OpenCV or VFleat, but I don't know how to implement it. So, I made my own code for that.

Later, I found a snippet on 'https://in.mathworks.com/help/vision/examples/automatically-detect-and-recognize-text-in-natural-images.html', a MATLAB help for Text Detection, which was distantly similar to SWT. So, I also used this new method to distinguish text.

In recognising stage, I used Neural Network to detect text from first stage. It's structure was, Input Layer: 400 units, One Hidden Layer: 160 units, Output Layer: 62 units. It was trained on training dataset from char74k.

My OCR is working fine but also have some constraints. Currently, I am working to increase its accuracy and to make it robust.
