def getInvisible():
    background=recordBackground()

    print("""
             Get ready to become invisible .....................
        """)
    cap = cv2.VideoCapture(whichCam)
    while(cap.isOpened()):
        ret, img = cap.read()
        frame = img
        img = np.flip(img,axis=1)

        # Converting image to HSV color space.
        hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
        value = (35, 35)

        blurred = cv2.GaussianBlur(hsv, value,0)

        lower_red = np.array([0,120,70])
        upper_red = np.array([10,255,255])
        mask1 = cv2.inRange(hsv,lower_red,upper_red)

        lower_red = np.array([170,120,70])
        upper_red = np.array([180,255,255])
        mask2 = cv2.inRange(hsv,lower_red,upper_red)

        # Addition of the two masks to generate the final mask.
        mask = mask1+mask2
        mask = cv2.morphologyEx(mask, cv2.MORPH_OPEN, np.ones((5,5),np.uint8))

        # Replacing pixels corresponding to cloak with the background pixels.
        img[np.where(mask==255)] = background[np.where(mask==255)]
        cv2.imshow('Stealth Mode Initiated',img)
        cv2.imshow("Source Video", frame)

        # Kill screen
        k = cv2.waitKey(1)
        if k == 27:
            cap.release()
            break

        # press "Q" to stop
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cv2.destroyAllWindows()

# Run function
getInvisible()
