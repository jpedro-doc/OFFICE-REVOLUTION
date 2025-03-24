# copy_to_embedded.py
import site, shutil, os

venv_site = site.getsitepackages()[0]
embedded_site = r"D:\OneDrive\Documentos\godot_projects\OFFICE-REVOLUTION\python\Lib\site-packages"
os.makedirs(embedded_site, exist_ok=True)

for item in os.listdir(venv_site):
    src = os.path.join(venv_site, item)
    dst = os.path.join(embedded_site, item)
    if os.path.isdir(src):
        shutil.copytree(src, dst, dirs_exist_ok=True)
    else:
        shutil.copy2(src, dst)
