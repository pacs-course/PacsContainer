#!/bin/bash
APPTAINER=/opt/mox/apptainer/bin/apptainer
$APPTAINER pull pacs-examples.sif docker://lucaformaggia/pacs-examples:latest
$APPTAINER build --sandbox pacs-examples.sbox  pacs-examples.sif
# now you can remuve the sif if you want

# This works but then yu should do export HOME=/home/pacs otherwise cd tries to bring you to 
# /u/username. I do not know how to specify that when running the apptainer command.
#/opt/mox/apptainer/bin/apptainer shell --no-home --containall -w  pacs-examples.sbox
