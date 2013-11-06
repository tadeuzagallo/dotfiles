#!/bin/bash

workspace=`ls . | grep *.xcworkspace`;
project=`ls . | grep *.xcproject`;

if [ "$workspace" ];
then
  open "$workspace";
elif [ "$project" ];
then
  open "$project";
else
  echo "Neither .xcworkspace or .xcproject found..."
fi
