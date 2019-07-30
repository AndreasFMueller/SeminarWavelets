# -*- coding: utf-8 -*-
"""
Created on Mon Jul 15 14:21:23 2019

@author: Cedric
"""

import glob
import os
import cairosvg


files = glob.glob("*.svg")
lst = [os.path.splitext(x)[0] for x in files]
for x in lst:
    cairosvg.svg2pdf(url='{}.svg'.format(x), write_to='{}.pdf'.format(x))
