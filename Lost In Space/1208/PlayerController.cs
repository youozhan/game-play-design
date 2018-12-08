using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System;
using System.Threading;
using System.IO.Ports;

public class PlayerController : MonoBehaviour {

    public float speed;
    public SimpleSerial SS;
    //private Rigidbody rb;
    //private int count;
    //public Text countText;
    //public Text winText;

    //public AudioSource bgm;

    private SerialPort serialPort = null;
    private String portName = "/dev/cu.usbmodem141301";
    private int baudRate =  9600;             
    private int readTimeOut = 100;

    private string serialInput;
    bool programActive = true;
    Thread thread;

	private void Start()
	{
        //rb = GetComponent<Rigidbody>();
        //count = 0;
        //SetCountTest();
        //winText.text = "";

        //GetComponent<AudioSource>().clip = bgm;

        try{
            serialPort = new SerialPort();
            serialPort.PortName = portName;
            serialPort.BaudRate = baudRate;
            serialPort.ReadTimeout = readTimeOut;
            serialPort.Open();
        }

        catch(Exception e){
            Debug.Log(e.Message);
        }

        thread = new Thread(new ThreadStart(ProcessData));
        thread.Start();
	}

    void ProcessData(){
        Debug.Log("Thread:Start");
        while(programActive){
            try{
                serialInput = serialPort.ReadLine();
            } catch(TimeoutException){
                
            }
        }
        Debug.Log("Thread:Stop");
    }

	private void FixedUpdate()
	{

        //float moveHorizontal = Input.GetAxis("Horizontal");
        //float moveVertical = Input.GetAxis("Vertical");

        //Vector3 movement = new Vector3(moveHorizontal, 0.0f, moveVertical);

        //rb.AddForce(movement * speed);

        if (Input.GetKey(KeyCode.RightArrow))
        {
            transform.Translate(new Vector3(speed * Time.deltaTime, 0, 0));
        }
        if (Input.GetKey(KeyCode.LeftArrow))
        {
            transform.Translate(new Vector3(-speed * Time.deltaTime, 0, 0));
        }
        if (Input.GetKey(KeyCode.DownArrow))
        {
            transform.Translate(new Vector3(0, 0, -speed * Time.deltaTime));
        }
        if (Input.GetKey(KeyCode.UpArrow))
        {
            transform.Translate(new Vector3(0, 0, speed * Time.deltaTime));
        }

        //if (SS.isPressed == true)
        //{
        //    //transform.position = new Vector3(-10 + SS.ControllerPos.x * 20 / 6, 0, -10 + SS.ControllerPos.y * 20 / 6);

        //    if (SS.ControllerPos.x >= 4)
        //    {
        //        transform.Translate(new Vector3(speed * Time.deltaTime, 0, 0));
        //    }
        //    if (SS.ControllerPos.x <= 3)
        //    {
        //        transform.Translate(new Vector3(-speed * Time.deltaTime, 0, 0));
        //    }
        //    if (SS.ControllerPos.y <= 3)
        //    {
        //        transform.Translate(new Vector3(0, 0, -speed * Time.deltaTime));
        //    }
        //    if (SS.ControllerPos.y >= 4)
        //    {
        //        transform.Translate(new Vector3(0, 0, speed * Time.deltaTime));
        //    }
        //}


    }

    private void OnTriggerEnter(Collider other)
	{
        if (other.gameObject.CompareTag("Pick Up"))
        {
            //other.gameObject.SetActive(false);
            //count++;
            //SetCountTest();
            GetComponent<AudioSource>().Play();
        }
	}

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.CompareTag("Pick Up"))
        {
            GetComponent<AudioSource>().Pause();
        }
    }

    //private void SetCountTest(){
    //    countText.text = "Count: " + count.ToString();
    //    if(count>=8){
    //        winText.text = "You win!";
    //    }
    //}

	public void OnDisable()
	{
        programActive = false;
        if (serialPort != null && serialPort.IsOpen)
            serialPort.Close();
	}
}
