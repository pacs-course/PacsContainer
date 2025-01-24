#!/bin/bash
APPTAINER=/opt/mox/apptainer/bin/apptainer
$APPTAINER pull pacs-examples.sif docker://lucaformaggia/pacs-examples:latest
$APPTAINER build --sandbox pacs-examples  pacs-examples.sif


#/opt/mox/apptainer/bin/apptainer shell  --containall -w --bind `pwd`/shared_files:/home/pacs/shared_files  pacs-examples.sif
