#!/bin/bash

resourceGroup=
location=
templateFile=

while [ "$1" != "" ]; do
    case $1 in
        -r | --resource-group )  shift
                                 resourceGroup=$1
                                 ;;
        -l | --location )        shift
                                 location=$1
                                 ;;
        -f | --template-file )   shift
                                 templateFile=$1
                                 ;;
        -h | --help )            echo 'Mandatory parameters'
                                 echo '-r or --resource-group'
                                 echo '-l or --location'
                                 echo '-f or --template-file'
                                 exit
                                 ;;
        * )                      echo 'Wrong parameters'
                                 exit
                                 ;;
    esac
    shift
done

if [ -z "$resourceGroup" ]; then
    echo "Parameter --resource-group is empty"
    exit
elif [ -z "$location" ]; then
    echo "Parameter --location is empty"
    exit
elif [ -z "$templateFile" ]; then
    echo "Parameter --template-file is empty"
    exit
fi

echo "Exeuting the script with the following parameters:"
echo "resource-group= $resourceGroup"
echo "location=$location"
echo "template-file= $templateFile"

az group create --name "$resourceGroup" --location $location
echo 'Azure resource group created successfully'

az deployment group create --resource-group $resourceGroup --template-file $templateFile
echo 'Azure deployment group created successfully'