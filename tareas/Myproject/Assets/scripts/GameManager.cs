using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

// Defines a new class that extends MonoBehaviour, allowing it to be attached to GameObjects.
public class NewBehaviourScript : MonoBehaviour
{
    // Lists to hold the sequences for player actions and the game's required actions.
    private List<int> playerTaskList = new List<int>();
    private List<int> playerSequenceList = new List<int>();

    // Holds a list of audio clips to play for button presses.
    public List<AudioClip> ButtonSoundsList = new List<AudioClip>();

    // A nested list of colors for button states (normal, highlighted).
    public List<List<Color32>> buttonColors = new List<List<Color32>>();

    // References to the clickable buttons in the game.
    public List<Button> clickableButtons; 

    // Audio clip to play when the player loses.
    public AudioClip loseSound;

    // The AudioSource component to play sounds.
    public AudioSource audioSource;

    // Not used directly in the provided script snippet.
    public CanvasGroup Button;

    // The GameObject representing the start button.
    public GameObject startbutton;

    // UI elements for displaying the current score and high score.
    public TMP_Text Score_text;
    public TMP_Text HighScore_text;

    // Variables to keep track of the score and high score.
    int Score = 0;
    int HighScore = 0;

    // Awake is called when the script instance is being loaded.
    void Awake()
    {
        // Initializes buttonColors with specific color sets for each button.
        buttonColors.Add(new List<Color32> { new Color32(255, 100, 100, 255), new Color32(255, 0, 0, 255) });
        buttonColors.Add(new List<Color32> { new Color32(255, 187, 10, 255), new Color32(255, 136, 0, 255) });
        buttonColors.Add(new List<Color32> { new Color32(162, 255, 124, 255), new Color32(72, 248, 0, 255) });
        buttonColors.Add(new List<Color32> { new Color32(57, 11, 255, 255), new Color32(0, 70, 255, 255) });

        // Sets the initial color of the buttons.
        for (int i = 0; i < 4; i++)
        {
            clickableButtons[i].GetComponent<Image>().color = buttonColors[i][0];
        }

        // Loads the high score from PlayerPrefs and updates the UI.
        HighScore = PlayerPrefs.GetInt("HighScore", 0);
        HighScore_text.text = "High Score: " + HighScore.ToString();
    }

    // Adds the button ID to the player's sequence list and checks the sequence.
    public void AddToPlayerSequenceList(int buttonId)
    {
        playerSequenceList.Add(buttonId);
        StartCoroutine(HighlightButton(buttonId));
        // Check if the sequence matches the task list.
        for (int i = 0; i < playerSequenceList.Count; i++)
        {
            if (playerTaskList[i] == playerSequenceList[i])
            {
                continue;
            }
            else
            {
                StartCoroutine(PlayerLost());
                return;
            }
        }
        // If sequences match, start the next round and update the score.
        if (playerSequenceList.Count == playerTaskList.Count)
        {
            StartCoroutine(StartNextRound());
            Score++;
            Score_text.text ="Score: " + Score.ToString();
        }
    }

    // Starts the game by resetting score and task list, then starts the first round.
    public void StartGame()
    {
        Score = 0;
        Score_text.text ="Score: " + Score.ToString();
        StartCoroutine(StartNextRound());
        startbutton.SetActive(false);
    }

    // Highlights a button for a brief period and plays its sound.
    public IEnumerator HighlightButton(int buttonId)
    {
        clickableButtons[buttonId].GetComponent<Image>().color = buttonColors[buttonId][1];
        audioSource.PlayOneShot(ButtonSoundsList[buttonId]);
        yield return new WaitForSeconds(0.5f);
        clickableButtons[buttonId].GetComponent<Image>().color = buttonColors[buttonId][0];
    }

    // Handles player losing: updates high score, plays lose sound, and resets game.
    public IEnumerator PlayerLost()
    {
        if (Score > HighScore)
        {
            HighScore = Score;
            PlayerPrefs.SetInt("HighScore", HighScore);
            HighScore_text.text = "High Score: " + HighScore.ToString();
        }

        audioSource.PlayOneShot(loseSound);
        playerSequenceList.Clear();
        playerTaskList.Clear();
        yield return new WaitForSeconds(2f);
        startbutton.SetActive(true);
    }

    // Generates a new sequence for the player to follow, disabling and then re-enabling button interaction.
    public IEnumerator StartNextRound()
    {
        playerSequenceList.Clear();
        foreach (Button btn in clickableButtons)
        {
            btn.interactable = false;
        }
        yield return new WaitForSeconds(1f);
        playerTaskList.Add(Random.Range(0, clickableButtons.Count));
        foreach (int index in playerTaskList)
        {
            yield return StartCoroutine(HighlightButton(index));
        }
        foreach (Button btn in clickableButtons)
        {
            btn.interactable = true;
        }
    }
}
