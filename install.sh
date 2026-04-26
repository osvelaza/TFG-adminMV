#!/bin/bash
git clone https://github.com/osvelaza/TFG-adminMV.git
ruta=$pwd/TFG-adminMV
sed -i -e "s|RUTAEDITAR|$ruta/GUI|g" http/user-data
mv tfg.desktop ~/.local/share/applications/
exit
