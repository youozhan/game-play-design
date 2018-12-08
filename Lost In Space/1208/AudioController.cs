using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioController : MonoBehaviour
{
    public SimpleSerial SS;
    AudioSource m_MyAudioSource;

    // Use this for initialization
    void Start()
    {
        //transform.position = new Vector3(Random.Range(-8, 8), 0.5f, Random.Range(-8, 8));
        m_MyAudioSource = GetComponent<AudioSource>();
    }

    // Update is called once per frame
    void Update () {
        if (SS.isPressed == true){
            Debug.Log("is pressed");
            m_MyAudioSource.Play();
        } else {
            //m_MyAudioSource.Stop();
            //Debug.Log("is not pressed");
        }

    }
}