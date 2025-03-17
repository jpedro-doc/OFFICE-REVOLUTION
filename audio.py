import librosa
import json

def analyze_music(file_path):
    y, sr = librosa.load(file_path)
    onset_env = librosa.onset.onset_strength(y=y, sr=sr)
    times = librosa.frames_to_time(librosa.onset.onset_detect(y=y, sr=sr))

    chart = [{"time": round(t, 2), "direction": "random"} for t in times]
    
    with open("chart.json", "w") as f:
        json.dump(chart, f)

analyze_music("./FREE Action Music Pack/2. Power Synth.wav")