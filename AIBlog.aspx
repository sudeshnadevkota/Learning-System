<%@ Page Title="Real-Time Face Recognition and Attendance System" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="AIBlog.aspx.cs" Inherits="Learning_System.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-5">
        <div class="text-center rounded-4 py-4">
            <img src="slide/facedetection.png" class="img-fluid w-100" style="height: 350px; border-radius: 10px; object-fit: contain" />
        </div>
        <h1 class="text-dark">Building a Real-Time Face Recognition and Attendance System Using OpenCV, Face Recognition, and Google Text-to-Speech</h1>
        <p>In today's world, face recognition technology has rapidly evolved, making its way into various applications from security systems to mobile devices. One interesting use case is in automated attendance systems, where the time-consuming process of manually taking attendance can be eliminated with the power of facial recognition. In this blog post, we will walk through the steps of building a real-time face recognition and attendance system using OpenCV, the face_recognition library, and Google Text-to-Speech (gTTS).</p>

        <h2 class="text-dark">Project Overview</h2>
        <p>The goal of this project is to create a system that can recognize faces in real-time using a webcam, identify the person, and then mark their attendance by writing their name and the time they were recognized to a CSV file. Additionally, the system will use text-to-speech technology to announce the name of the recognized person.</p>

        <h2 class="text-dark">Prerequisites</h2>
        <p>Before we dive into the code, let's make sure you have the necessary tools and libraries installed:</p>
        <ul>
            <li>Python</li>
            <li>OpenCV</li>
            <li>face_recognition</li>
            <li>gTTS</li>
        </ul>
        <p>You can install these libraries using pip:</p>
        <div class="code-container">
            <div class="d-flex justify-content-end mb-2">
                <button class="copy-btn text-light bg-primary" onclick="copyToClipboard('installCommand')">Copy Code</button>
            </div>
            <pre><code id="installCommand">pip install opencv-python face-recognition gtts</code></pre>
        </div>

        <h2 class="text-dark">Step 1: Preparing the Training Images</h2>
        <p>The first step is to gather a set of training images. These images should contain the faces of the individuals you want to recognize. Store these images in a folder named <strong>training images</strong>. Each image file should be named after the person it contains, as this name will be used to identify the person during recognition.</p>

        <div class="code-container">
            <div class="d-flex justify-content-end mb-2">
                <button class="copy-btn text-light bg-primary" onclick="copyToClipboard('trainingImagesCode')">Copy Code</button>
            </div>
            <pre><code id="trainingImagesCode">import cv2
import numpy as np
import face_recognition
import os
from datetime import datetime
from gtts import gTTS
import time</code></pre>
        </div>

        <h2 class="text-dark">Step 2: Loading and Encoding the Images</h2>
        <p>The next step is to load the training images and convert them into a format that the face_recognition library can use. This involves reading each image, converting it from BGR (the default format used by OpenCV) to RGB, and then generating a face encoding for each image.</p>

        <div class="code-container">
            <div class="d-flex justify-content-end mb-2">
                <button class="copy-btn text-light bg-primary" onclick="copyToClipboard('encodingCode')">Copy Code</button>
            </div>
            <pre><code id="encodingCode">path = 'training images'  # Path to the images folder
images = []
classNames = []
myList = os.listdir(path)

for cl in myList:
    curImg = cv2.imread(f'{path}/{cl}')
    images.append(curImg)
    classNames.append(os.path.splitext(cl)[0])

def findEncodings(images):
    encodeList = []
    for img in images:
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        encode = face_recognition.face_encodings(img)[0]
        encodeList.append(encode)
    return encodeList

encodeListKnown = findEncodings(images)</code></pre>
        </div>

        <h2 class="text-dark">Step 3: Marking Attendance</h2>
        <p>Once a face is recognized, we need to record the attendance by writing the person’s name and the current time to a CSV file. This is done by checking if the person has already been marked for the day, and if not, appending their information to the file. We also use the gTTS library to announce the name of the person as they are recognized.</p>

        <div class="code-container">
            <div class="d-flex justify-content-end mb-2">
                <button class="copy-btn text-light bg-primary" onclick="copyToClipboard('attendanceCode')">Copy Code</button>
            </div>
            <pre><code id="attendanceCode">def markAttendance(name):
    with open('Attendance.csv','r+') as f:
        myDataList = f.readlines()
        nameList = []
        for line in myDataList:
            entry = line.split(',')
            nameList.append(entry[0])
            
        if name not in nameList:
            now = datetime.now()
            dtString1 = now.strftime('%H:%M:%S')
            dtString2 = now.strftime('%A')
            dtString3 = now.strftime('%d:%m:%Y')
            f.writelines(f'\n{name},{dtString1},{dtString2},{dtString3}')

            # Speak the recognized name
            language = 'en'
            output = gTTS(text=f'hello {name}', lang=language, slow=False)
            output.save("output.mp3")
            os.system("start output.mp3")
            time.sleep(3)
            os.remove('output.mp3')</code></pre>
        </div>

        <h2 class="text-dark">Step 4: Capturing and Processing Video</h2>
        <p>The main loop of the program captures frames from the webcam, processes them to detect faces, and then compares these detected faces with the known encodings. If a match is found, the person's name is displayed on the video feed, and their attendance is marked.</p>

        <div class="code-container">
            <div class="d-flex justify-content-end mb-2">
                <button class="copy-btn text-light bg-primary" onclick="copyToClipboard('videoCode')">Copy Code</button>
            </div>
            <pre><code id="videoCode">cap = cv2.VideoCapture(0)

while True:
    success, img = cap.read()
    imgS = cv2.resize(img, (0, 0), None, 0.25, 0.25)
    imgS = cv2.cvtColor(imgS, cv2.COLOR_BGR2RGB)
    
    facesCurFrame = face_recognition.face_locations(imgS)
    encodesCurFrame = face_recognition.face_encodings(imgS, facesCurFrame)
    
    for encodeFace, faceLoc in zip(encodesCurFrame, facesCurFrame):
        matches = face_recognition.compare_faces(encodeListKnown, encodeFace)
        faceDis = face_recognition.face_distance(encodeListKnown, encodeFace)
        matchIndex = np.argmin(faceDis)
        
        if matches[matchIndex]:
            name = classNames[matchIndex]
            y1, x2, y2, x1 = faceLoc
            y1, x2, y2, x1 = y1*4, x2*4, y2*4, x1*4
            cv2.rectangle(img, (x1, y1), (x2, y2), (0, 255, 0), 2)
            cv2.rectangle(img, (x1, y2-35), (x2, y2), (0, 255, 0), cv2.FILLED)
            cv2.putText(img, name, (x1+6, y2-6), cv2.FONT_HERSHEY_COMPLEX, 1, (255, 255, 255), 2)
            markAttendance(name)
    
    cv2.imshow('my video', img)
    if cv2.waitKey(13) & 0xFF == ord('q'):
        cv2.destroyAllWindows()
        break</code></pre>
        </div>

        <h2 class="text-dark">Step 5: Running the Program</h2>
        <p>Finally, you can run the program and test it with different faces. Make sure to have your webcam set up and properly configured. When you run the script, it will start capturing video and recognizing faces in real-time. Ensure you have the training images folder with the correct images before running the program.</p>

        <div class="code-container">
            <div class="d-flex justify-content-end mb-2">
                <button class="copy-btn text-light bg-primary" onclick="copyToClipboard('runCode')">Copy Code</button>
            </div>
            <pre><code id="runCode">python face_recognition_attendance.py</code></pre>
        </div>

        <h2 class="text-dark">Conclusion</h2>
        <p>This real-time face recognition and attendance system is a great way to explore computer vision and machine learning technologies. By integrating OpenCV, face_recognition, and gTTS, you can build a practical application that demonstrates the power of these technologies. Experiment with the code and adapt it to your own needs!</p>


        <p class="my-5">
            <a href="https://github.com/subashsigdel/Automatic-attendence_project.git" target="_blank" class="btn btn-primary">
                <i class="fab fa-github"></i>View on GitHub
            </a>
        </p>
        <div class="d-flex justify-content-end">
            <a href="Default.aspx" class="btn btn-primary text-light">Back to home</a>
        </div>
    </div>
    <style>
        /* General styling for the code containers */
        .code-container {
            border: 1px solid #ddd;
            border-radius: 0.25rem;
            background-color: #f8f9fa;
            padding: 1rem;
            margin-bottom: 1.5rem;
            position: relative;
        }

        /* Button to copy code */
        .copy-btn {
            border: none;
            border-radius: 0.25rem;
            padding: 0.5rem 1rem;
            cursor: pointer;
            font-size: 0.875rem;
            position: absolute;
            right: 1rem;
            top: 1rem;
        }

        /* Adjust the appearance of the code block */
        pre {
            margin: 0;
            overflow-x: auto;
        }

        /* Style for code elements */
        code {
            display: block;
        }
    </style>
</asp:Content>
