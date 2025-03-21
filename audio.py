import librosa
import librosa.display
import json
import numpy as np

def hz_to_note(freq):
    if freq == 0:
        return "N/A"
    note_names = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    A4 = 440.0 
    n = round(12 * np.log2(freq / A4)) 
    note_index = (n + 9) % 12  
    return note_names[note_index]

def analyze_music(file_path):
    y, sr = librosa.load(file_path)

    onset_frames = librosa.onset.onset_detect(y=y, sr=sr, units="frames")
    times = librosa.frames_to_time(onset_frames, sr=sr)

    S = np.abs(librosa.stft(y))
    freqs = librosa.fft_frequencies(sr=sr)

    detected_notes = []

    for frame, time in zip(onset_frames, times):
        spectrum = S[:, frame] 
        peak_freq = freqs[np.argmax(spectrum)]  
        note = hz_to_note(peak_freq)

        detected_notes.append({"time": round(time, 2), "note": note})


    with open("notes_chart.json", "w") as f:
        json.dump(detected_notes, f, indent=4)

    print(f"✅ Analysis complete! Detected notes saved to 'notes_chart.json'.")


analyze_music("Assets/Music/4. Pow Pow Lazers.wav")
