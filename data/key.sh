function makeSignature() {
	nl=$'\\n'

	TIMESTAMP=$(echo $(($(date +%s%N)/1000000)))
	ACCESSKEY=$ACCESSKEY
	SECRETKEY=$SECRETKEY

	METHOD="GET"
	URI="/vserver/v2/addAccessControlGroupInboundRule?regionCode=KR&vpcNo=$VPCNO&accessControlGroupNo=$ACCESSCONTROLGROUPNO&accessControlGroupRuleList.1.protocolTypeCode=TCP&accessControlGroupRuleList.1.ipBlock=$IP&accessControlGroupRuleList.1.portRange=8888"

	echo $IP

	SIG="$METHOD"' '"$URI"${nl}
	SIG+="$TIMESTAMP"${nl}
	SIG+="$ACCESSKEY"

	SIGNATURE=$(echo -n -e "$SIG"|iconv -t utf8 |openssl dgst -sha256 -hmac $SECRETKEY -binary|openssl enc -base64)


	echo $SIGNATURE

	curl -i -v -X $METHOD \
		'https://ncloud.apigw.ntruss.com'$URI \
		-H "Content-type:application/json" \
		-H "x-ncp-apigw-timestamp:$TIMESTAMP" \
		-H "x-ncp-iam-access-key:$ACCESSKEY" \
		-H "x-ncp-apigw-signature-v2:$SIGNATURE"

}

token=$( makeSignature )