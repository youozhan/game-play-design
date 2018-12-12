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

    AudioSource footsteps;

    // public Transform target;
    Vector3 target;

	private void Start(){
        footsteps = GetComponent<AudioSource>();
        footsteps.volume = 0.0f;
        transform.position = new Vector3(0, 0, 0);
	}

	private void FixedUpdate()
	{

        // if (Input.GetKey(KeyCode.RightArrow))
        // {
        //     transform.Translate(new Vector3(speed * Time.deltaTime, 0, 0));
        // }
        // if (Input.GetKey(KeyCode.LeftArrow))
        // {
        //     transform.Translate(new Vector3(-speed * Time.deltaTime, 0, 0));
        // }
        // if (Input.GetKey(KeyCode.DownArrow))
        // {
        //     transform.Translate(new Vector3(0, 0, -speed * Time.deltaTime));
        // }
        // if (Input.GetKey(KeyCode.UpArrow))
        // {
        //     transform.Translate(new Vector3(0, 0, speed * Time.deltaTime));
        // }

        // if (SS.isPressed == true)
        // {
            float step = speed * Time.deltaTime;

            if(SS.ControllerPos.x > 0 && SS.ControllerPos.y > 0) {
                target = new Vector3(-10 + (SS.ControllerPos.x - 1) * 20 / 8, 0, -10 + (SS.ControllerPos.y - 1) * 20 / 8);
                footsteps.volume = 0.5f;
            }

            transform.position = Vector3.MoveTowards(transform.position, target, step);

            if(Vector3.Distance(transform.position, target) == 0.0){
                footsteps.volume = 0.0f;
            }


    }
}
