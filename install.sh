#!/bin/bash

echo "    ===> Creating new scratch org"
sfdx force:org:create -s -a XOrg -f config/project-scratch-def.json
echo "    ===> Pushing source..."
sfdx force:source:push
echo "    ===> Assigning pemissions..."
sfdx force:user:permset:assign -n dreamhouse
echo "    ===> Importing development data..."
sfdx force:data:tree:import -p assets/data/Broker__c-Property__c-plan.json
echo "    ===> Environment setup complete."