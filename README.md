# c19_watcher

## Table Of Content
 1.Overview
 
 2.Application 
 
 3.Deep Learning
 
     a)Face Mask Detection
     
     b)Social Distancing
     
     c)Temperature Detection using Thermal Integration
     
 
 
## OverView
C19 Watcher is an application that is suitable for Post Pandemic work Environment.
Our Goal is to achieve a safe work Environment where all the social norms such as Social Distancing, Wearing a Mask, and checking body temperature is done through minimal human interaction.
For this we have created various Machine Learning and Deep Learning models which can be implemented on any camera module and all of this is integrated into a fast serverless application known as C19 Watcher.


## Application Development(Frontend and Backend)

This project is a starting point for a Flutter application.

This is our UI of the application->

  <a href="https://ibb.co/bdbKtZ1"><img width="225px" src="https://i.ibb.co/s3WV7Gj/Screenshot-20201004-014746.jpg" alt="Screenshot-20201004-014746" border="0"></a>
  
  This is the login Page.
  
  <a href="https://ibb.co/3RNjp43"><img width="225px" src="https://i.ibb.co/5K8SrG0/Screenshot-20201004-014819.jpg" alt="Screenshot-20201004-014819" border="0"></a>
  
  This is our home Page.
  
  This page is for the live interface of the camera.
  
  <a href="https://ibb.co/YTG33XS"><img width="225px" src="https://i.ibb.co/vv8HHhW/Screenshot-20201004-014827.jpg" alt="Screenshot-20201004-014827" border="0"></a>
  
  
 ## Deep Learning/Machine Learning 
  a)Social Distancing Model
  
In the social distancing model we have used Facebook's detectron2 model for object detection and localization, this gives us a bounding box around all the people in the frame and then we used the scipys spatial model for calculating the distance between all the people out of which the minimum distance is taken and if that is less than the threshold an alert is sent to the database.


  
  <a href="https://imgbb.com/"><img width="500px" src="https://i.ibb.co/x6jzwR5/ezgif-com-gif-maker.gif" alt="ezgif-com-gif-maker" border="0"></a>
  
  
  
 b)Face Recognition and Face Mask detection
 
 The second and third model are integrated together so the model returns the persons name who is not wearing a mask along with his photo, for face mask detection we have used mobilenet's model for object classification and using opencv we are creating a bounding box around the face. And for face recognition we used adam geitgeys face recognition module.
  
  <a href="https://imgbb.com/"><img width="225px" src="https://i.ibb.co/sCZpZsk/face1.jpg" alt="face1" border="0"></a>
  
  <a href="https://imgbb.com/"><img width="225px" src="https://i.ibb.co/6sTsW3C/face2.jpg" alt="face2" border="0"></a>

  
  

