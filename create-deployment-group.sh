#!/bin/bash

resourceGroup=
location=
templateFile=
parameters=

#init script params
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
        -p | --parameters )      shift
                                 parameters=$1
                                 ;;
        -h | --help )            echo 'Mandatory parameters'
                                 echo '-r or --resource-group'
                                 echo '-l or --location'
                                 echo '-f or --template-file'
                                 echo '-p or --parameters'
                                 exit
                                 ;;
        * )                      echo 'Wrong parameters'
                                 exit
                                 ;;
    esac
    shift
done

#check for mandatory params
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

#create azure resource group
az group create --name "$resourceGroup" --location $location

#create group deployment using templating file
if [ -z "$parameters" ]; then
    az deployment group create --resource-group $resourceGroup --template-file $templateFile
else
    az deployment group create --resource-group $resourceGroup --template-file $templateFile --parameters $parameters
fi