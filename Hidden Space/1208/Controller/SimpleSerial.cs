using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System;
using System.IO.Ports;
using System.Threading;

public class SimpleSerial : MonoBehaviour
{

    private SerialPort serialPort = null;
    private String portName = "/dev/cu.usbmodem141301";  // set this to the name of your serial port, ie "/dev/tty.usbmodem1411"
    private int baudRate = 9600;  // use matching baudrate from your arduino, commonly 9600
    private int readTimeOut = 100;

    private string serialInput;

    public string[] Numbers = new string[36];
    public int Space;

    public GameObject TargetObject;
    public Vector2 ControllerPos;

    bool programActive = true;
    Thread thread;

    int row = 0;
    int col = 0;
    int TargetInt;

    public bool isPressed;

    void Start()
    {
        try
        {
            serialPort = new SerialPort();
            serialPort.PortName = portName;
            serialPort.BaudRate = baudRate;
            serialPort.ReadTimeout = readTimeOut;
            serialPort.Open();
        }
        catch (Exception e)
        {
            Debug.Log(e.Message);
        }
        thread = new Thread(new ThreadStart(ProcessData));  // Setting ProcessData function to be a new Thread
        thread.Start();
    }

    void ProcessData()
    {
        Debug.Log("Thread: Start");
        while (programActive)
        {
            try
            {
                serialInput = serialPort.ReadLine();  // reading in serial input
            }
            catch (TimeoutException)
            {

            }
        }
        Debug.Log("Thread: Stop");
    }

    void Update()
    {
        if (serialInput != null)  // the code below is expecting "analog, analog, digital" like "291,905,1" from arduino serial
        {
            //Debug.Log(serialInput);
            string[] strEul = serialInput.Split(',');

            TargetInt = -1;
            isPressed = false;
            for (int i = 0; i < 36; i++)
            {
                Numbers[i] = strEul[i];

                if (int.Parse(Numbers[i]) < 100)
                {
                    row = col = 0;
                    //Debug.Log(i + " was pressed");
                    TargetInt = i;
                    isPressed = true;

                }


                if (TargetInt != -1)
                {

                    for (int j = 0; j < TargetInt; j++)
                    {
                        if (row >= 6)
                        {
                            row = 0;
                            col++;
                        }
                        //if (col >= 6)
                        //{
                        //    col = 0;
                        //}
                        row++;
                    }

                    if (row >= 6) row = 0;
                    Debug.Log(row + " " + col);

                    ControllerPos = new Vector2(row, col);
                    TargetInt = -1;
                }

                //TargetObject.transform.position = new Vector3(-row * Space, 0, -col * Space);
            } 
        }





    }

    public void OnDisable()  // closes serial port when unity runtime is closed
    {
        programActive = false;
        if (serialPort != null && serialPort.IsOpen)
            serialPort.Close();
    }
}