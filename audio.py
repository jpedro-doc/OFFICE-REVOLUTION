import librosa
import librosa.display
import json
import numpy as np
import matplotlib.pyplot as plt

def hz_to_note(freq):
    """Convert frequency (Hz) to musical note."""
    if freq == 0:
        return "N/A"
    note_names = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    A4 = 440.0  # Reference frequency
    n = round(12 * np.log2(freq / A4))  # Convert to semitone distance from A4
    note_index = (n + 9) % 12  # Align to note names
    return note_names[note_index]

def analyze_music(file_path):
    y, sr = librosa.load(file_path)

    # Compute onset envelope (detects beats)
    onset_env = librosa.onset.onset_strength(y=y, sr=sr)
    onset_frames = librosa.onset.onset_detect(y=y, sr=sr, units="frames")
    times = librosa.frames_to_time(onset_frames, sr=sr)

    # Compute the Short-Time Fourier Transform (STFT)
    S = np.abs(librosa.stft(y))
    freqs = librosa.fft_frequencies(sr=sr)

    detected_notes = []

    for frame, time in zip(onset_frames, times):
        spectrum = S[:, frame]  # Get spectrum at beat
        peak_freq = freqs[np.argmax(spectrum)]  # Find dominant frequency
        note = hz_to_note(peak_freq)

        detected_notes.append({"time": round(time, 2), "note": note})

    # Save to JSON
    with open("notes_chart.json", "w") as f:
        json.dump(detected_notes, f, indent=4)

    # Plot detected beats
    plt.figure(figsize=(10, 4))
    librosa.display.waveshow(y, sr=sr, alpha=0.5)
    plt.vlines(times, ymin=-1, ymax=1, color='r', linestyle='dashed', label="Detected Beats")
    plt.legend()
    plt.title("Detected Beats in Audio")
    plt.xlabel("Time (s)")
    plt.ylabel("Amplitude")
    plt.show()

    print(f"✅ Analysis complete! Detected notes saved to 'notes_chart.json'.")

# Run the analysis on your audio file
analyze_music("Assets/Music/3. Sirens Before the Drop.wav")
