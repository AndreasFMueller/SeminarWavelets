# -*- coding: utf-8 -*-
"""
Created on Mon Jul 15 14:21:23 2019

@author: Cedric
"""

import glob
import os

import img2pdf 
from PIL import Image 

files = glob.glob("*.jpg")
lst = [os.path.splitext(x)[0] for x in files]
#for x in lst:
#    cairosvg.svg2pdf(url='{}.svg'.format(x), write_to='{}.pdf'.format(x))


  
# converting into chunks using img2pdf 
for x in lst:
    img2pdf.convert('{}.png'.format(x), outputstream='{}.pdf'.format(x))
  
  
# storing image path 
img_path = "C:/Users/Admin/Desktop/GfG_images/do_nawab.png"
  
# storing pdf path 
pdf_path = "C:/Users/Admin/Desktop/GfG_images/file.pdf"
  
# opening image 
image = Image.open(img_path) 
  
# converting into chunks using img2pdf 
pdf_bytes = img2pdf.convert(image.filename) 
  
# opening or creating pdf file 
file = open(pdf_path, "wb") 
  
# writing pdf files with chunks 
file.write(pdf_bytes) 
  
# closing image file 
image.close() 
  
# closing pdf file 
file.close() 
  
# output 
print("Successfully made pdf file") 