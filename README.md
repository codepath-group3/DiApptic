#GlucoApp
###The Problem
Imagine you have just discovered that you are diabetic and you would need to carefully manage your blood glucose for the rest of your life. This requires a strict discipline of watching what you eat, maintaining the regular physical activity level, being aware of your blood glucose levels and keeping a close eye on it. Over the long period of time these tasks become tiring and motivation to continue that discipline starts fading away which can cause serious long term health damages. 
###The Solution
As humans we always do better when we have support and we work with others. With GlucoApp you can not only record and monitor your own blood glucose, food intake, medication but also can share that information with the other people who are suffering from the same condition. You can share tips and information that is working for you and follow others who have proven to manage their own diabetes well over a long period of time. The idea of this app is to let the community support and motivate each other to live healthy with this condition. The app would also try to keep the users motivated by rewarding good habbits and will improve your ranking to have more influence in the community. 

##Features
1. Login (Required)
  * User downloads the app and opens it the first time
  * Present with the login/registration screen
  * The user enters the email and password and clicks on register
  * At this state the user has preregistered and would need to be presented a Full registration screen
  * Full registration/Profile information screen will be presentented that asks
  First name, last name, gender(optional), phone number(optional), profile picture(optional)
  This screen will have a Save button (no cancel action will be provided)
  Upon Save the user is navigated to the home screen
  * Example of login screen: <img src="https://s-media-cache-ak0.pinimg.com/564x/4a/77/02/4a7702ef781394369a77a30c00a1edeb.jpg" width="200">

2. Login with identity provider(Optional)
  * The user is on the login screen and is not registered yet
  * The login screen would have buttons to login with 
  - facebook
  - google
  - any other oauth providers
  * User clicks on of the buttons to login with an identity provider
  * Using Oauth fetch the user details and populate in our own db
  * Take the user to home screen

3. A user can record a blood glucose reading that would include:
  * Timestamp of the reading
  * Actual measurement
  * Context of reading: Before breakfast, Before meal/snack, After meal/snack, General. In case of after meal record amount of carbs taken in the meal
  * Medication taken = Insulin, Oral
  * Any physical activity
  * Any additional note
4. Record HbA1c
  * The actual reading
  * Any note that can be saved as part of the reading
  * The screen shows the last reading and the months/days since last reading
5. Trend View
  * The user is logged in and wants to see the history
  * Take the user to the history view which contains two sections
  * Section 1 will have a pie chart at the top
  * Section 2 Line graph at the bottom
  * The pie chart would update based on the period selection from the line chart
  * The pie chart would have highs, lows and normals as the sections
  * Example: <img src="http://a4.files.theultralinx.com/image/upload/c_fit,cs_srgb,dpr_2.0,q_40,w_620/MTI5MDIyNTEzMDEwMjE4MjU4.jpg" width="200">
5. View history of blood glucose readings 
  1. Detail view
    * daily/weekly/monthly
    * Each reading should include the details of each reading
    * Based on the time period selected there should be 
  2. Summary view
    * A graph of the time period selected
    * Average of the time period selected
    * Number of high readings
    * Number of low readings
    * Number of normal readings
6. View history of HbA1c readings as a graph
7. Home screen
  * Includes a message at the top that gives a textual summary of their activity e.g.
    1. Hi John Doe, you have been following the structure very rigorously. You are a warrior. Keep up the good work.
    2. Hi John Doe, you have not recorded your blood glucose level for three days. Studies show that recording blood glucose levels regularly is a key step towards ensuring your long term health.
    3. Hi John Doe, Your HbA1c test is due in another month. With the current discipline we expect you to have great results in your next test result.
  * Shows a list of shared messages from other friends like a story feed. The user can "high five" the message or reply to it
  * Each time a user records a reading it will show up in other members story feed. Depending upon how much information can be shared this message can be as short as "John Doe recorded their reading" or it may have additional information as to what the actual reading was and what other details were recorded as part of the reading.
  * Upon clicking the user's profile image the feed will show messages by only that particular user.
8. Post a message
  * User can post a shared message that will show in other members story feed
  * User can add an image to the message
  * User may choose to share the last reading as part of the message
  * The message can be posted as public or shared only with friends
9. Reminders and Notifications
10. Settings
  * Language selection
  * Personal information (name, profile image, profession)
  * Privacy and security include options
    1. Share everytime I record a reading (public/friends only)
    2. Share everytime I record an HbA1c reading (public/ friends only)
11. Profile View
  * <img src="https://d13yacurqjgara.cloudfront.net/users/198986/screenshots/1367326/dribbble.jpg" width="200">


##Models
#### User
| Name          | Type          | Required     |
| ------------- | --------------| -------------|
|id  |  number |
|last name  |  string |
|first name  |  string |
|username  |  string |
|email  |  string |
|password  |  string |
|date joined  |  Date |
|profile image  |  ?? (how does parse handle images)|
|profession  |  string (perhaps an enum)|
|friends:   |  [list of users] |
|last modified  |  Date |
|last logged in  |  Date |


####Reading
| Name          | Type          | Required     |
| ------------- | --------------| -------------|
id  | number |
|type   | string enum (blood glucose, HbA1c) |
|timestamp  | Date |
|value  | number |
|medication_type  | string enum (insulin, oral) |
|context   | string enum (Before Breakfast, Before meal/snack, After meal/snack, General) |
|carbs_taken  | integer |
|physical_activity  | string enum  (none, mild, moderate, high) |
|note  | string |
|shared  | boolean |
|shared_with  | [public/ friends only] |


####Story
| Name          | Type          | Required     |
| ------------- | --------------| -------------|
|id  | number |
|timestamp  | Date |
|message  | Message Object |
|liked  | boolean |
|replied  | boolean |
|reading  | Reading Object |
|user (posted by user)  | User Object |
|like_count  | number |
|shared   | boolean |
|shared_with  | boolean |


####Message
| Name          | Type          | Required     |
| ------------- | --------------| -------------|
|id  | number |
|timestamp  | Date |
|text  | string |
|in_reply_to   | story object |
