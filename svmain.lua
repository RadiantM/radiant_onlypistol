RegisterNetEvent('radiant:setBucket')
AddEventHandler('radiant:setBucket', function(bucket)
    local _source = source
	SetPlayerRoutingBucket(_source, bucket)
end)
