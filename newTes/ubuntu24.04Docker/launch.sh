#!/bin/bash
#cd /home/oscar/Dam2/TFG/newTes/ubuntu24.04/
#rm -rf output/
#PACKER_LOG=1 packer build template.pkr.hcl
#exit
cd $1
rm -rf output/
packer build template.pkr.hcl
estado=$?
[ $estado -eq 0 ] && echo "Ejecución correcta" || echo "Error"
exit
