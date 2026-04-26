#!/bin/bash
git clone https://github.com/osvelaza/TFG-adminMV.git
ruta=$($pwd/TFG-adminMV)
nueva=$($ruta/GUI)
sed -i -e "s|RUTAEDITAR||g" $ruta/tfg.desktop
mv $ruta/tfg.desktop ~/.local/share/applications/
exit
