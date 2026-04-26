#!/bin/bash
cd $1
rm -rf output/
PACKER_LOG=1 packer build template.pkr.hcl
exit
