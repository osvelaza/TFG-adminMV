#!/bin/bash
git clone https://github.com/osvelaza/TFG-adminMV.git
ruta=$pwd/TFG-adminMV
sed -i -e "s|RUTAEDITAR|$ruta/GUI|g" $ruta/tfg.desktop
mv $ruta/tfg.desktop ~/.local/share/applications/
exit
