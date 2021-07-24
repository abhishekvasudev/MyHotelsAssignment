# My Hotels Application

## About
This is a simple iOS application to that helps to maintain record of hotels the user want to track.

## Purpose
This application is a submission as per assignment requirement for ServiceNow

## Installation and configuration
You can clone/download the repository and build the project. The project is built in <b>XCode 12.3</b><br>

## Documentation
### Design Pattern
MVVM
### Assignment Requirement
<b> Main Screen: </b> Allows the user to see list of hotel records. User can also add, edit, or delete hotel.<br>
<b> Add/Edit Screen: </b> Allows the user to add/edit hotel record <br>
### Additional Implementation
1) <b>DataStore: </b> Helps maintain single source of truth for our data. <br>
2) I have implemented a logic that enables the save button only when existing values are modified. Although the Date of Stay doesn't function properly as I am not ignoring the time that the DatePicker gives with the date. <br>
### Areas of Improvement
1) Validation logic to prevent add two hotels of same name <br>
2) Navigation logic to help maintain data flow smoothly <br>

## GIF
<a href=""><img src="Video/MyHotelsAppGif.gif" title="My Hotels App"/></a>
