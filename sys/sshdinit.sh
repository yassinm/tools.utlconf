#on the server !
PubkeyAcceptedKeyTypes=+ssh-dss

#for newer ubuntu systems you need to add tho the client
ssh -oPubkeyAcceptedKeyTypes=+ssh-dss ymo-vm
