# YerbaMate
Simple application for a mock dating service
Built using Flutter, Dart for frontend and Express (NodeJS) for backend (and to host the frontend).

## Instructions to run (have `npm` installed prior)
1. Download the project files into your computer
2. Navigate to the project on your terminal/command line
3. Run the following commands

```cmd
cd .\yerba_backend\
npm i
npm run devStart
```
4. Find application running on `localhost:3000/#/`
5. Run the application on full screen

## To run the flutter app separate from the server
1. Go until step 2. in the previous set of instructions
2. Run the following commands
```cmd
cd .\yerba_mate\
flutter run
2
```
NOTE: the flutter app alone is disconnected from the express backend. To host a new version of the frontend using express:
```cmd
flutter build web
```
