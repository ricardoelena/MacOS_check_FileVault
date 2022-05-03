#!/bin/bash

declare -a checkFin
checkfin=""

TRUE="true"
FALSE="false"
TEST_ERR=n

# Command Line options
while getopts 'd' OPTION; do
  case "$OPTION" in
    d)
      TEST_ERR=y 	# Enable Error Testing
      ;;
    *)
      exit 1
      ;;
  esac
done

#File Vault Status

FV2Status=$(fdesetup status | grep "On")
[[ "${TEST_ERR}" == "y" ]] && FV2Status=

if [ "$FV2Status" ]; then
    Encrypted="${TRUE}"
else
    Encrypted="${FALSE}"
    checkFin+=('-Drive not Encrypted')
fi

if [[ $Encrypted == "${TRUE}" ]]; then
Compliant="${TRUE}";
fi

# Return "$TRUE" or a concatenated string of errors seperated by a hyphen I.E> "- <message>"
if [[ $Compliant != "${TRUE}" ]]; then
    result=${checkFin[@]}
else
    result=$Compliant
fi

# echo "<result>$result</result>"
echo "$result"

# End
