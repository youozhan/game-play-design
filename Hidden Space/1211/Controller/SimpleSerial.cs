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
    private String portName = "/dev/cu.usbmodem144401";  // set this to the name of your serial port, ie "/dev/tty.usbmodem1411"
    private int baudRate = 9600;  // use matching baudrate from your arduino, commonly 9600
    private int readTimeOut = 100;

    private string serialInput;

    //public string[] Numbers = new string[36];
    public int Space;

    public GameObject TargetObject;
    public Vector2 ControllerPos;

    bool programActive = true;
    Thread thread;

    int row = 0;
    int col = 0;
    //int TargetInt;

    public bool isPressed = false;

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

    void FixedUpdate()
    {
        if (serialInput != null)  // the code below is expecting "analog, analog, digital" like "291,905,1" from arduino serial
        {
            //Debug.Log(serialInput);
            string[] strEul = serialInput.Split(',');

            //TargetInt = -1;
            //isPressed = false;

            if(strEul.Length > 0)
            {
                if(int.Parse(strEul[0]) != 0)
                {
                    isPressed = true; 
                } else {
                    isPressed = false;
                }

                if (int.Parse(strEul[1]) != 0)
                {
                    row = int.Parse(strEul[1]);
                }
                else
                {
                    row = 0;
                }

                if (int.Parse(strEul[2]) != 0)
                {
                    col = int.Parse(strEul[2]);
                }
                else
                {
                    col = 0;
                }
            }

            ControllerPos = new Vector2(row, col);
        }



    }

    public void OnDisable()  // closes serial port when unity runtime is closed
    {
        programActive = false;
        if (serialPort != null && serialPort.IsOpen)
            serialPort.Close();
    }
}