# Photo-OCR-Octave

I am trying to build a Photo OCR in Octave. It will recognize the optical characters or simply text from the given photo. Photo here need not to be just text only. It can be any natural photo like a pic of a busy street.

I am not any expert programmer. I have no experience in Computer Vision or Machine Learning. This is my first project on ML and after starting it, I found that I also need basics of Computer Vision for processing the image.

This project is just in it's initial stages. I am working on the preprocessing image before recognising stage. 
In preprocessing, main task is to detect the text region from the whole picture. In MATLAB, MSER is very common and useful way to detect text area. But both MATLAB and Computer Vision System Toolbox(the toolbox containing MSER) are paid. So, I am trying to implement them in Octave by coding required features myself, so that I can also enhance my coding skills.

Currently, I am working on Stroke Width Transform method to detect text from other regions. SWT, is not available anywhere(or I am not able to get it because I am not an expert). It is available through OpenCV or VFleat, but I don't know how to implement it. So, I am making my own code for that. 
