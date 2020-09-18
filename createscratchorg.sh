#First we create a scratch org
if [ $# -eq 0 ]; then
sfdx force:org:create -f config/project-scratch-def.json -s
else
sfdx force:org:create -f config/project-scratch-def.json -s -a $1
fi
#Install required packages
#Financial Services cloud
#sfdx force:package:install --package 04t1E000000cmtN --noprompt --wait=30
#push source code
sfdx force:source:push
#assign permission set to the default user
sfdx force:user:permset:assign -n ebikes
#import sample data
sfdx force:data:tree:import -p ./data/sample-data-plan.json
#deploy metadata that isn't available in source format (yet)
sfdx force:mdapi:deploy -d mdapiDeploy/unpackaged -w 5
#publish community
sfdx force:community:publish -n E-Bikes
#open scratch org
sfdx force:org:open
