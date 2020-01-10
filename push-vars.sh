HOST=app.terraform.io
ORG=jacobm3
WS=az-vault

#tfe workspace create -tfe-address $HOST -tfe-org $ORG -tfe-workspace $WS 

tfe pushvars -dry-run false -overwrite-all true -name ${ORG}/${WS} \
 -tfe-address $HOST \
 -env-var ARM_SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID \
 -env-var ARM_TENANT_ID=$ARM_TENANT_ID \
 -env-var ARM_CLIENT_ID=$ARM_CLIENT_ID \
 -senv-var ARM_CLIENT_SECRET=$ARM_CLIENT_SECRET
