using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class GameController : MonoBehaviour
{

    public GameObject dotPrefab;
    public GameObject dot;
    public float force;

    public int pointsLeft = 0;
    public int pointsRight = 0;

    public TMP_Text leftScore;
    public TMP_Text rightScore;

    public int maxPoints;


    // Start is called before the first frame update
    void Start()
    {
        StartGame();
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.R)) {
            Destroy(dot);
            StartGame();
        }
    }

public void StartGame()
    {
        dot=Instantiate(dotPrefab);
        dot.GetComponent<Rigidbody2D>().velocity = Random.onUnitSphere * force;
    }

    public void Reset(){
        Destroy(dot);
        StartGame();
    }

public void AddPoints(int side)
{
    if (side == 1)
    {
        pointsLeft++;
        if (pointsLeft >= maxPoints){
        leftScore.text = "Score" + pointsLeft.ToString();
        } else {
        leftScore.text = pointsLeft.ToString();
        Reset();
        }
        
    }
    else
    {
        pointsRight++;
        if (pointsRight >= maxPoints) {
        rightScore.text = "Score" + pointsRight.ToString();
        } else {
        rightScore.text = pointsRight.ToString();
        Reset();
        }
    }

    Destroy(dot);
    StartGame();
}}

