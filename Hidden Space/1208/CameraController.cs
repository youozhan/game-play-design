using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour {

    public GameObject player;

    private Vector3 offset;
    //public float speed;

    // Use this for initialization
    void Start () {
        offset = transform.position - player.transform.position;
		
	}

    //void Update()
    //{
    //    if (Input.GetKey(KeyCode.RightArrow))
    //    {
    //        transform.Translate(new Vector3(speed * Time.deltaTime, 0, 0));
    //    }
    //    if (Input.GetKey(KeyCode.LeftArrow))
    //    {
    //        transform.Translate(new Vector3(-speed * Time.deltaTime, 0, 0));
    //    }
    //    if (Input.GetKey(KeyCode.DownArrow))
    //    {
    //        transform.Translate(new Vector3(0, -speed * Time.deltaTime, 0));
    //    }
    //    if (Input.GetKey(KeyCode.UpArrow))
    //    {
    //        transform.Translate(new Vector3(0, speed * Time.deltaTime, 0));
    //    }
    //}

    // Update is called once per frame
    void LateUpdate () {
           transform.position = player.transform.position + offset;

    }
}
