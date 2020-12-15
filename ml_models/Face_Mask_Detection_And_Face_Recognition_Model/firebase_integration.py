#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Oct  3 02:20:53 2020

@author: khush
"""

import requests
import os
from firebase_admin import credentials, initialize_app, storage
# Init firebase with your credentials
cred = credentials.Certificate("c19watcher-bd93edd80c0e.json")
initialize_app(cred, {'storageBucket': 'c19watcher.appspot.com'})

def post_request(f_name,loc,n):
  fileName = f_name
  bucket = storage.bucket()
  blob = bucket.blob(fileName)
  blob.upload_from_filename(fileName)
  print("post_request")

  # Opt : if you want to make public access from the URL
  blob.make_public()

  print("your file url", blob.public_url)

  url = "https://c19watcher.firebaseio.com/FaceDetection.json"
  no = loc
  payload = '{"Location": '+ no +'}'
  headers = {
    'Content-Type': 'application/json'
  }

  response = requests.post(url, json={"Location": no, "ImageUrl": blob.public_url, "Mask" : 1,"name":n})

  print(response.text.encode('utf8'))
  
import os
def main(img_name,n,mask):
    IMG_PATH = "/home/khush/Desktop/IVY_HACKS/Face-Mask-Detection/images"
    
    try :
        single_image_path = os.path.join(IMG_PATH, img_name)
    
        post_request(single_image_path,"A",n)
    
    except:
        pass