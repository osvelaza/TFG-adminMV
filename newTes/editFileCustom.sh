#!/bin/bash
cd ../newTes/$1

mkdir ../../personalizados/$2

cp -r http/ ../../personalizados/$2/
cp template.pkr.hcl ../../personalizados/$2/
cp launch.sh ../../personalizados/$2/
cp virsh.sh  ../../personalizados/$2/

cd ../../personalizados/$2/

sed -i -e "8!s/usuario/$3/g" template.pkr.hcl
sed -i -e "8!s/contrasenaacambiar/$4/g" template.pkr.hcl

sed -i -e "8!s/usuario/$3/g" http/user-data
sed -i -e "s/usuario/$3/g" http/preseed.cfg
sed -i -e "8!s/usuario/$3/g" http/fedora.ks

password=$(mkpasswd -m sha-512 $4)
original='contrasenaacambiar'
sed -i -e "s|$original|$password|g" http/user-data
sed -i -e "s|$original|$4|g" http/preseed.cfg
sed -i -e "s|$original|$4|g" http/fedora.ks

echo $password

sed -i -e "8!s/15/$5/g" template.pkr.hcl
sed -i -e "8!s/4096/$6/g" template.pkr.hcl
sed -i -e "8!s/20G/$7G/g" template.pkr.hcl
