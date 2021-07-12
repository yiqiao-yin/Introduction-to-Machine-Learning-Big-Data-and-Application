# Begin function
def StarterMode(whichCam=2):
    # Credits: I sourced the code from the following:
    # author: Arun Ponnusamy
    # website: https://www.arunponnusamy.com
    # github: https://github.com/arunponnusamy/cvlib/blob/a21fc330cddb5e06dd82e0acf77e934ae413adee/cvlib/face_detection.py

    # face detection webcam example
    # usage: python face_detection_webcam.py 

    # import necessary packages
    import numpy as np
    import random
    import cvlib as cv
    import cv2

    # open webcam
    webcam = cv2.VideoCapture(whichCam)

    if not webcam.isOpened():
        print("Could not open webcam")
        exit()

    # loop through frames
    while webcam.isOpened():

        # read frame from webcam 
        status, frame = webcam.read()

        if not status:
            print("Could not read frame")
            exit()

        # apply face detection
        # upgrade 1: 
        # there is a build-in CNN
        # that looks for human face inside of the frame
        # frame is coming from camera live feed
        # low-level AI here
        face, confidence = cv.detect_face(frame)

#             print(face)
#             print(confidence)

        # loop through detected faces
        for idx, f in enumerate(face):

            # location
            (startX, startY) = f[0], f[1]
            (endX, endY) = f[2], f[3]
            startXleft = startX - 120
            endXright = endX + 120

            # draw rectangle over face
            cv2.rectangle(frame, (startXleft, startY), (endXright, endY), (0,255,0), 2)
            text = "Starter Mode Initiated:"
            textConf = "Confidence: " + "{:.2f}%".format(confidence[idx] * 100)
            Y = startY - 10 if startY - 10 > 10 else startY + 10

            # write output
            cv2.putText(frame, text, (startXleft,Y-20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,255,0), 2)
            cv2.putText(frame, textConf, (startXleft,Y-5), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,255,0), 2)
            cv2.circle(frame, (int(round(startX+0.75*(endX-startX),0)), int(round(startY+0.35*(endY-startY),0))), random.randint(40, 50), (0,255,0), 1)

            # write date
            from datetime import datetime
            now = datetime.now()
            dt_string = now.strftime("%Y-%m-%d %H:%M:%S")
            textDate = "Date & Time: " + str(dt_string)
            cv2.putText(frame, textDate, (startXleft,endY+15), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,255,0), 2)

            # write market: SPY
            import yfinance as yf # yahoo finance | same with quantmod(), i.e. in quantmod() the default API is yahoo finance
            import pandas as pd
            from datetime import date
            today = date.today()
            start_date = pd.to_datetime('2013-01-01')
            end_date = pd.to_datetime(str(today))
            SPY = yf.download("SPY", start_date, end_date) # live data
            DIA = yf.download("DIA", start_date, end_date) # live data
            textSPY = "S&P 500 Last Day Close: " + str(round(SPY.iloc[len(SPY)-1][3], 2)) + "; Volume: " + str(round(SPY.iloc[len(SPY)-1][5], 2))
            textDIA = "Dow Jones Index Last Day Close: " + str(round(DIA.iloc[len(DIA)-1][3], 2)) + "; Volume: " + str(round(DIA.iloc[len(DIA)-1][5], 2))
            # backend
            # do more (in backend) in machine learning
            # do RNN
            # do prediction
            # I wake up today, my google glass automatically tell me today's closing price within 7 bucks error margin
            cv2.putText(frame, textSPY, (startXleft,endY+30), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,255,0), 2)
            cv2.putText(frame, textDIA, (startXleft,endY+45), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,255,0), 2)

        # display output
        # this is front-end
        cv2.imshow("Starter Mode Initiation", frame)

        # press "Q" to stop
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    # release resources
    webcam.release()
    cv2.destroyAllWindows()
